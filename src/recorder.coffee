class window.Recording
  constructor: ->
    navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia  unless navigator.getUserMedia
    @sampleRate = 44100
    @errors     = []
    @setNastyGlobals()
    if navigator.getUserMedia
      navigator.getUserMedia  {audio: true} , @sample, @failure
    else
      @errors.push "Browser does not support WebRTC."
  setNastyGlobals: ->
    ###
      I am open to input on this one. I tried to confine these variables to the local instance,
      but it appears as though AudioContext#onaudiprocess does not preserve context well (yes, 
      I tried using the fat arrow).
    ###
    window.simpleAudioConfig = 
      is_recording    : no
      leftchannel     : []
      rightchannel    : []
      recordingLength : 0
    null
  sample: (current_stream) ->
    AudioCtx = window.AudioContext or window.webkitAudioContext
    context = new AudioCtx()
    volume = context.createGain()
    audioInput = context.createMediaStreamSource(current_stream)
    audioInput.connect volume
    ### From the spec: This value controls how frequently the audioprocess event is 
        dispatched and how many sample-frames need to be processed each call. 
        Lower values for buffer size will result in a lower (better) latency. 
        Higher values will be necessary to avoid audio breakup and glitches 
    ###
    bufferSize = 1024
    recorder = context.createScriptProcessor(bufferSize, 2, 2)
    recorder.onaudioprocess = (current_stream) ->
      #This function just passes audio through it and collects it within a typed array.
      #Profile this.
      return  unless simpleAudioConfig.is_recording
      left = current_stream.inputBuffer.getChannelData(0)
      right = current_stream.inputBuffer.getChannelData(1)
      # we clone the samples
      simpleAudioConfig.leftchannel.push new Float32Array(left)
      simpleAudioConfig.rightchannel.push new Float32Array(right)
      simpleAudioConfig.recordingLength += bufferSize
    # we connect the recorder
    volume.connect recorder
    recorder.connect context.destination
  start: ->
    simpleAudioConfig.is_recording = yes

    # reset the buffers for the new recording
    simpleAudioConfig.leftchannel.length = simpleAudioConfig.rightchannel.length = 0
    simpleAudioConfig.recordingLength = 0
    console.log "Recording now..."
  stop: ->
    # we stop recording
    recording = no

    # we flat the left and right channels down
    leftBuffer  = @_mergeBuffers(simpleAudioConfig.leftchannel, simpleAudioConfig.recordingLength)
    rightBuffer = @_mergeBuffers(simpleAudioConfig.rightchannel, simpleAudioConfig.recordingLength)

    # we interleave both channels together
    interleaved = @_interleave(leftBuffer, rightBuffer)
    
    # we create our wav file
    buffer = new ArrayBuffer(44 + interleaved.length * 2)
    view = new DataView(buffer)

    # RIFF chunk descriptor
    @_writeUTFBytes view, 0, "RIFF"
    view.setUint32 4, 44 + interleaved.length * 2, true
    @_writeUTFBytes view, 8, "WAVE"

    # FMT sub-chunk
    @_writeUTFBytes view, 12, "fmt "
    view.setUint32 16, 16, true
    view.setUint16 20, 1, true

    # stereo (2 channels)
    view.setUint16 22, 2, true
    view.setUint32 24, simpleAudioConfig.sampleRate, true
    view.setUint32 28, simpleAudioConfig.sampleRate * 4, true
    view.setUint16 32, 4, true
    view.setUint16 34, 16, true

    # data sub-chunk
    @_writeUTFBytes view, 36, "data"
    view.setUint32 40, interleaved.length * 2, true

    # write the PCM samples
    lng = interleaved.length
    index = 44
    volume = 1
    i = 0

    while i < lng
      view.setInt16 index, interleaved[i] * (0x7FFF * volume), true
      index += 2
      i++

    # our final binary blob
    @blob = new Blob([view],
      type: "audio/wav"
    )
    @url = (window.URL || window.webkitURL).createObjectURL(@blob)
    @setNastyGlobals()
  download: (fileName = 'output.wav') ->
    link = window.document.createElement("a")
    link.href = @url
    link.download = fileName
    click = document.createEvent("Event")
    click.initEvent "click", true, true
    link.dispatchEvent click

  _interleave: (leftChannel, rightChannel) ->
    length = leftChannel.length + rightChannel.length
    result = new Float32Array(length)
    inputIndex = 0
    index = 0

    while index < length
      result[index++] = leftChannel[inputIndex]
      result[index++] = rightChannel[inputIndex]
      inputIndex++
    result

  _mergeBuffers: (channelBuffer, recordingLength) ->
    result = new Float32Array(recordingLength)
    offset = 0
    lng = channelBuffer.length
    i = 0

    while i < lng
      buffer = channelBuffer[i]
      result.set buffer, offset
      offset += buffer.length
      i++
    result

  _writeUTFBytes: (view, offset, string) ->
    lng = string.length
    i = 0

    while i < lng
      view.setUint8 offset + i, string.charCodeAt(i)
      i++
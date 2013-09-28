describe "Recorder", ->

  describe "recording", ->

    it 'starts', ->
      ### Let's talk about this first spec...
       This spec adds a 2000 milisec pause to give the tester adequate time to 
       click the 'allow' button on their browser. I am not particularly happy
       with this as it is sloppy, but I have not seen a solution out there that
       fixes the issue while maintaining portability of the repo / keeping all
       configuration within the repo. Please submit a pull request if you have a
       better way of doing this.
      ###
      window.recording1 = new Recording()
      waits(2000)
      recording1.start()

    it "clears error log on initialize", ->
      expect(recording1.errors.length).toEqual(0)

    it "sets a sample rate", ->
      expect(recording1.sampleRate).toEqual(44100)

    it "turns on recording flag", ->
      expect(simpleAudioConfig.is_recording).toEqual(yes)

    it "populates left channel samples", ->
      expect(simpleAudioConfig.leftchannel).not.toEqual([])

    it "populates right channel samples", ->
      expect(simpleAudioConfig.rightchannel).not.toEqual([])

    it "populates recording length data", ->
      expect(simpleAudioConfig.recordingLength).toBeGreaterThan(0)

    it "stops the recorder", ->
      recording1.stop()

    it "turns off recorder flag after recording", ->
      expect(simpleAudioConfig.is_recording).toEqual(no)

    it "clears left channel after recording", ->
      expect(simpleAudioConfig.leftchannel).toEqual([])

    it "clears right channel after recording", ->
      expect(simpleAudioConfig.rightchannel).toEqual([])

    it "clears recording length after recording", ->
      expect(simpleAudioConfig.recordingLength).toEqual(0)

    it "creates a Blob object", ->
      expect(recording1.blob.constructor.name).toEqual("Blob")

    it "sets Blob meta data", ->
      expect(recording1.blob.type).toEqual("audio/wav")
      

    it "sets WAV binary file headers", ->
      #WAV binary file headers are 44 bytes long (excluding audio data)
      expect(recording1.blob.size).toBeGreaterThan(43)

    it "populats audio data", ->
      #the 45th byte and onward are audio.
      expect(recording1.blob.size).toBeGreaterThan(45)

    it "creates a URL object", ->
      expect(recording1.url.toString()).toMatch('http')
      expect(recording1.url.toString()).toMatch('blob')

  # describe 'helper methods', ->
  #   #TODO: This stuff.
  #   it 'write utf bytes', ->
  #     #_writeUTFBytes etc etc. Pull requests welcome.
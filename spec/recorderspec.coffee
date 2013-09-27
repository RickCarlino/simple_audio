describe "Recorder", ->

  beforeEach ->
    @recording = new Recording()
    #TODO: Use a callback to wait for user to click permissions. 
    #This is just a simple 2 second timeout until a more elegant solution arises.
    waits(2000)
    @recording.start()

  it "Records audio", ->
    expect(@recording.errors.length).toEqual(0)
    expect(@recording.sampleRate).toEqual(44100)
    expect(window.__recording).toEqual(yes)
    expect(window.__leftchannel).not.toEqual([])
    expect(window.__rightchannel).not.toEqual([])
    expect(window.__recordingLength).toBeGreaterThan(0)
    @recording.stop()
    expect(window.__recording).toEqual(no)
    expect(window.__leftchannel).toEqual([])
    expect(window.__rightchannel).toEqual([])
    expect(window.__recordingLength).toEqual(0)
    expect(@recording.blob.constructor.name).toEqual("Blob")
    expect(@recording.blob.type).toEqual("audio/wav")
    #WAV binary file headers are 44 bytes long (excluding audio data)
    expect(@recording.blob.size).toBeGreaterThan(45)
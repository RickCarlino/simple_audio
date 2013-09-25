describe "Recorder", ->
  beforeEach ->
    @recording = new Recording

  it "initializes", ->
    expect(@recording.errors.length).toEqual(0)
    expect(@recording.sampleRate).toEqual(44100)

  it "sets and resets global variables (sorry...)", ->
    window.__recording         = -99
    window.__leftchannel       = -99
    window.__rightchannel      = -99
    window.__recordingLength   = -99
    @recording.setNastyGlobals()
    expect(window.__recording).toEqual(no)
    expect(window.__leftchannel).toEqual([])
    expect(window.__rightchannel).toEqual([])
    expect(window.__recordingLength).toEqual(0)

  it 'starts', ->
    @recording.start()
    #TODO: This spec.
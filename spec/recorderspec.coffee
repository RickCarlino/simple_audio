# expect(x).toEqual(y)
# expect(x).not.toEqual(y)
# expect(x).toBe(y)
# expect(x).toMatch(pattern)
# expect(x).toBeDeﬁned()
# expect(x).toBeUndeﬁned()
# expect(x).toBeNull()
# expect(x).toBeNaN()
# expect(x).toBeTruthy()
# expect(x).toBeFalsy()
# expect(x).toContain(y)
# expect(x).toBeLessThan(y)
# expect(x).toBeGreaterThan(y)
# expect(x).toBeCloseTo(y, precision)
# expect(function(){fn();}).toThrow(e)
# expect(spy).toHaveBeenCalled()
# expect(spy).toHaveBeenCalledWith(arguments)

describe "Recorder", ->
  beforeEach ->
    @recording = new Recording()

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
    #TODO: This spec.
    @recording.start()
    waits(500)
    @recording.stop()
    expect(@recording.blob.length).toBeGreaterThan(44)
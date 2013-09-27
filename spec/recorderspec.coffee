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
    #TODO: Use a callback to wait for user to click permissions. 
    #This is just a simple 2 second timeout until a more elegant solution arises.
    waits(2000)
    @recording.start()
    waits(5000)
    @recording.stop()

  it "Records audio", ->
    expect(@recording.errors.length).toEqual(0)
    expect(@recording.sampleRate).toEqual(44100)
    expect(window.__recording).toEqual(no)
    expect(window.__leftchannel).toEqual([])
    expect(window.__rightchannel).toEqual([])
    expect(window.__recordingLength).toEqual(0)
    expect(@recording.blob.constructor.name).toEqual("Blob")
    expect(@recording.blob.type).toEqual("audio/wav")
    expect(@recording.blob.size).toBeGreaterThan(45)

#Simple Audio

A simple audio recorder for the web. Work in progress.

###Examples:

Record a file:

```coffeescript
thing = new Recorder()
thing.record()
```

Stop recording:

```coffeescript
thing.stop()
```

Get a reference the file (returns a (URL Object)[https://developer.mozilla.org/en-US/docs/Web/API/window.URL])

```coffeescript
thing.file()
```

The example above makes it possible to pin the return value to a link or post to the server via AJAX.
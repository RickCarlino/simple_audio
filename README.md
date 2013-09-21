#Simple Audio

A simple audio recorder for the web. Work in progress.

###Examples:

####Record a file:

```coffeescript
voice = new Recorder()
voice.record()
```

####Stop recording:

```coffeescript
voice.stop()
```

####Get a reference the file
returns a [URL Object](https://developer.mozilla.org/en-US/docs/Web/API/window.URL)

```coffeescript
voice.file()
```
The example above makes it possible to pin the return value to a link or post to the server via AJAX.

####Download the file locally

```coffeescript
voice.download()
```

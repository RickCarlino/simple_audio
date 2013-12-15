#Simple Audio

A simple audio recorder for the web.

**[Live Demo](http://rickcarlino.github.io/simple_audio/)**

###Credits
This project is based heavily off of a blog post by [Thibault Imbert](http://typedarray.org/from-microphone-to-wav-with-getusermedia-and-web-audio/) as well as this [great talk by Chris Wilson](https://www.youtube.com/watch?v=hFsCG7v9Y4c).

###Word of Warning
**These APIs are constantly changing.** Many of the technologies used in this plugin have not been finalized and may be subject to change. Proceed with caution.

### Up and running

####Adding it to a page
Just download ```src/recorder.js``` to your project and require it via 

```html
<script type="text/javascript" src="src/recorder.js"></script>
```

#### Contributing / Running the test suite
 n. After cloning, install dependencies via ```npm install```.
 n. Run ```npm start```. This will autocompile coffeescript and serve static files at [http://localhost:8888](http://localhost:8888).
 n. Take a look at [http://localhost:8888/index.html](http://localhost:8888/index.html) and [http://localhost:8888/SpecRunner.html](http://localhost:8888/SpecRunner.html).

###Examples:

####Record a file:

```coffeescript
voice = new Recording()
voice.start()
```

####Stop Recording:

```coffeescript
voice.stop()
```

####Reference the File
returns a [URL Object](https://developer.mozilla.org/en-US/docs/Web/API/window.URL)

```coffeescript
voice.file()
```
The example above makes it possible to pin the return value to a link or post to the server via AJAX.

####Download the File Locally

```coffeescript
voice.download()
```

Optionally, you may specify a filename for the download.

```coffeescript
voice.download('whatdoesthefoxsay.wav')
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/rickcarlino/simple_audio/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


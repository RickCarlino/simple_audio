#This is the sourcecode to the demo seen on the repo's github page.
$ ->
  $('#init').on 'click', (e) ->
    e.preventDefault()
    window.recording1 = new Recording()
    $('#start').attr('href', '#')
    $(this).text('')
  $('#start').on 'click', (e) ->
    e.preventDefault()
    window.recording1.start()
    $('#stop').attr('href', '#')
    $(this).text('')
  $('#stop').on 'click', (e) ->
    e.preventDefault()
    window.recording1.stop()
    $('#dl').attr('href', '#')
    $(this).text('')
  $('#dl').on 'click', (e) ->
    e.preventDefault()
    window.recording1.download('wowSuperCool.wav')
    $(this).text('')

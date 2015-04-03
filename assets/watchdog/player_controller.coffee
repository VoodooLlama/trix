class Trix.Watchdog.PlayerController
  constructor: (@element, @recording) ->
    @player = new Trix.Watchdog.Player @recording
    @player.delegate = this

    @view = new Trix.Watchdog.PlayerView @element
    @view.delegate = this

    @view.setLength(@player.length)
    @view.setSpeed(@player.speed)
    @player.seek(0)

  play: ->
    @player.play()

  stop: ->
    @player.stop()

  playerViewDidClickPlayButton: ->
    if @player.isPlaying()
      @player.stop()
    else
      @player.play()

  playerViewDidClickDecreaseSpeedButton: ->
    @player.decreaseSpeed()

  playerViewDidClickIncreaseSpeedButton: ->
    @player.increaseSpeed()

  playerViewDidChangeSliderValue: (value) ->
    @player.seek(value)

  playerViewDidChangeSpeed: (speed) ->
    @player.setSpeed(speed)

  playerDidSeekToIndex: (index) ->
    @view.setIndex(index)

    if snapshot = @player.getSnapshot(index)
      @view.renderSnapshot(snapshot)

    if events = @player.getEvents(index)
      @view.renderEvents(events)

  playerDidStartPlaying: ->
    @view.playerDidStartPlaying()

  playerDidStopPlaying: ->
    @view.playerDidStopPlaying()

  playerDidChangeSpeed: (speed) ->
    @view.setSpeed(speed)

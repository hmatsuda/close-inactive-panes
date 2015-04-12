{CompositeDisposable} = require 'atom'

module.exports = CloseInactivePanes =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that closes this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'close-inactive-panes:close': => @close()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  close: ->
    activePane = atom.workspace.getActivePane()
    for pane in atom.workspace.getPanes()
      if pane isnt activePane
        pane.destroy()

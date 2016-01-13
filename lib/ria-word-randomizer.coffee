{CompositeDisposable} = require 'atom'
{$} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'ria-word-randomizer:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText().split("")
      selectionLength = selection.length
      i = selectionLength

      #console.log( "Selected word : " + selection )
      #console.log( "Word length : " + selectionLength )

      for i in [ i - 1 ... 0 ]
        #console.log( "Swap remaining : " + i )
        # As i is decreasing with each iteration, randomNumber will always be between i and 0
        randomNumber = Math.floor( Math.random() * i )
        #console.log( "Iteration randomNumber : " + randomNumber )
        # We swap the letters in places i and randomNumber
        temporary = selection[ i ]
        selection[ i ] = selection[ randomNumber ]
        selection[ randomNumber ] = temporary
        #console.log( "Iteration swap : swapping " + selection[ i ] + " with " + selection[ randomNumber ] )
        #console.log( "New word : " + selection )

      #console.log( "Result word : " + selection )
      # At the end of the loop, we return the word with its letters randomly swapped
      return editor.insertText( selection.join("") )

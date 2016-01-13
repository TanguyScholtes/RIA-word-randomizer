RIAWordRandomizer = require '../lib/ria-word-randomizer'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "RIAWordRandomizer", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('ria-word-randomizer')

  describe "when the ria-word-randomizer:convert event is triggered", ->
    it "randomizes the letters of a selected word", ->

      expect(workspaceElement.querySelector('.ria-word-randomizer')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'ria-word-randomizer:convert'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.ria-word-randomizer')).toExist()

        rIAWordRandomizerElement = workspaceElement.querySelector('.ria-word-randomizer')
        expect(rIAWordRandomizerElement).toExist()

        rIAWordRandomizerPanel = atom.workspace.panelForItem(rIAWordRandomizerElement)
        expect(rIAWordRandomizerPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'ria-word-randomizer:convert'
        expect(rIAWordRandomizerPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.ria-word-randomizer')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'ria-word-randomizer:convert'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        rIAWordRandomizerElement = workspaceElement.querySelector('.ria-word-randomizer')
        expect(rIAWordRandomizerElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'ria-word-randomizer:convert'
        expect(rIAWordRandomizerElement).not.toBeVisible()

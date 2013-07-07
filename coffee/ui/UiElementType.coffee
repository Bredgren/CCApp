
class UiElementType
  constructor: (@name) ->

window.uiElementType =
  element: new UiElementType("element")
  button: new UiElementType("button")

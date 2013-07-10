
class UiElementType
  constructor: (@name) ->

window.uiElementType =
  element: new UiElementType("element")
  textElement: new UiElementType("textElement")

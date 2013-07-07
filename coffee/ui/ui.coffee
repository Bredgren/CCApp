#= require UiElement
#= require UiElementType
#= require UiHelpers
  # for updateCollection

# Attributes of Ui Manager:
#
# element: UiElement[String]
#
class UiManager
  constructor: () ->
    @elementCollection_ = {}

  element: (name) ->
    return @elementCollection_[name]

  elementIs: (name, type) ->
    updateCollection(@elementCollection_, name, type)

window.uiManager = new UiManager()

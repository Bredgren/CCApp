#= require UiElementType
#= require UiHelpers

# Attributes of UiElement:
#
# name: String constant
# type: UiElementType constant
# parent: UiElement
# child: UiElement[String]
#
class UiElement
  type_: uiElementType.element

  constructor: (@name_) ->
    @childCollection_ = {}
    @parent_ = null

  name: () ->
    return @name_

  type: () ->
    return @type_

  parent: () ->
    return @parent_

  parentIs: (element) ->
    @parent_ = element

  child: (name) ->
    return @childCollection_[name]

  childIs: (name, type) ->
    updateCollection(@childCollection_, name, type)
    @childCollection_[name].parentIs(@)

class UiButton extends UiElement
  type_: uiElementType.button

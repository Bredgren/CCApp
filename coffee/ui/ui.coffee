#= require UiElement
#= require UiElementType
#= require UiHelpers
#= require UiNotifier

# Attributes of Ui Manager:
#
# element: UiElement[String]
# input: UiPosition
#
class UiManager extends Notifier
  constructor: () ->
    super()
    @elementCollection_ = {}
    @input_ = new UiPosition(null, null)
    @prev_input_ = new UiPosition(null, null)

  element: (name) ->
    return @elementCollection_[name]

  elementIs: (name, type) ->
    if updateCollection(@elementCollection_, name, type)
      @notify_('element', name, type)
    return @elementCollection_[name]

  input: () ->
    return @input_

  inputIs: (input) ->
    return if input.equal(@input_)
    @prev_input_.xIs(@input_.x())
    @prev_input_.yIs(@input_.y())
    @input_.xIs(input.x())
    @input_.yIs(input.y())
    @notify_('input', @input_, @prev_input_)

window.uiManager = new UiManager()

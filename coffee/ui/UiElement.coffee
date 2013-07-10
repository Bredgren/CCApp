#= require UiElementType
#= require UiHelpers
#= require UiPosition
#= require UiNotifier

# Attributes of UiElement:
#
# name: String constant
# type: UiElementType constant
# parent: UiElement
# child: UiElement[String]
# visible: Boolean
# active: Boolean
# topLeft: UiPosition
# bottomRight: UiPosition
#
class UiElement extends Notifier
  type_: uiElementType.element

  constructor: (@name_, @parent_=null) ->
    super()
    @childCollection_ = {}
    @visible_ = false
    @active_ = false
    @topLeft_ = new UiPosition(0, 0)
    @bottomRight_ = new UiPosition(0, 0)
    @enter_action_ = null
    @leave_action_ = null
    @press_action_ = null
    @release_action_ = null
    if not @parent_
      uiManager.notifieeIs('input', @handleInput)

  name: () ->
    return @name_

  type: () ->
    return @type_

  visible: () ->
    return @visible_

  visibleIs: (visible) ->
    @visible_ = visible

  active: () ->
    return @active_

  activeIs: (active) ->
    return if active == @active_
    @active_ = active
    @notify_('active', active)

  parent: () ->
    return @parent_

  parentIs: (element) ->
    @parent_ = element

  child: (name) ->
    return @childCollection_[name]

  childIs: (name, type) ->
    updateCollection(@childCollection_, name, type, @)
    return @childCollection_[name]

  topLeft: () ->
    return @topLeft_

  topLeftIs: (position) ->
    return if position.equal(@topLeft_)
    @topLeft_.xIs(position.x())
    @topLeft_.yIs(position.y())

  bottomRight: () ->
    return @bottomRight_

  bottomRightIs: (position) ->
    return if position.equal(@bottomRight_)
    @bottomRight_.xIs(position.x())
    @bottomRight_.yIs(position.y())

  enterActionIs: (func) ->
    @enter_action_ = func

  leaveActionIs: (func) ->
    @leave_action_ = func

  pressActionIs: (func) ->
    @press_action_ = func

  releaseActionIs: (func) ->
    @release_action_ = func

  handleInput: (args) =>
    return if not @active_
    console.log(@name_, "is handling input")
    input = args[0]
    prev = args[1]

    if (not input.isNull() and @positionWithin_(input)) or
       (not prev.isNull() and @positionWithin_(prev))
      for name, child of @childCollection_
        child.handleInput(args)

    if input.isNull()
      if not prev.isNull() and @positionWithin_(prev)
        @release_action_?()
    else
      if prev.isNull() # input not null, prev nul
        if @positionWithin_(input)
          @press_action_?()
      else # both not null
        if @positionWithin_(input)
          if not @positionWithin_(prev)
            @enter_action_?()
        else
          if @positionWithin_(prev)
            @leave_action_?()

  positionWithin_: (position) ->
    return @topLeft_.x() <= position.x() and
           position.x() <= @bottomRight_.x() and
           @topLeft_.y() <= position.y() and
           position.y() <= @bottomRight_.y()

# Attributes unique to UiTextElement:
#
#
class UiTextElement extends UiElement
  type_: uiElementType.textElement

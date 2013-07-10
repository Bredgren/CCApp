
# Attributes of UiPosition:
#
# x: Number
# y: Number
#
class window.UiPosition
  constructor: (@x_, @y_) ->

  x: () ->
    return @x_

  xIs: (x) ->
    return if x == @x_
    @x_ = x

  y: () ->
    return @y_

  yIs: (y) ->
    return if y == @y_
    @y_ = y

  equal: (other) ->
    return other.x() == @x_ and other.y() == @y_

  isNull: () ->
    return @x_ == null and @y_ == null
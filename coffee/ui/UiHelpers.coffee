#= require UiElement
#= require UiElementType

updateCollection = (collection, name, type, parent=null) ->
  current = collection[name]
  return false if current and current.type == type

  switch type
    when uiElementType.element
      collection[name] = new UiElement(name, parent)
    when uiElementType.button
      collection[name] = new UiButton(name, parent)

  return true

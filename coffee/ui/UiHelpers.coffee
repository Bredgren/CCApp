#= require UiElement
#= require UiElementType

updateCollection = (collection, name, type) ->
  current = collection[name]
  return if current and current.type == type

  switch type
    when uiElementType.element
      collection[name] = new UiElement(name)
    when uiElementType.button
      collection[name] = new UiButton(name)

# The main file

main = ->
  canvas = document.getElementById('theCanvas')
  width = window.innerWidth
  height = window.innerHeight
  console.log("canvas: #{canvas}")
  canvas.width = width
  canvas.height = height
  console.log("Setting canvas size to (#{width}, #{height})")

  ctx = canvas.getContext('2d')

  ctx.strokeStyle = "rgb(0, 0, 255)"
  ctx.strokeRect(5, 5, width-10, height-10)

  uiManager.elementIs("e1", uiElementType.element)

  e1 = uiManager.element('e1')
  e1.childIs("b1", uiElementType.button)
  console.log("e1:", e1.type(), e1)
  b1 = uiManager.element('e1').child('b1')
  console.log("b1:", b1.type(), b1)

  # input move
  onInputMove = (e) ->

  # input start
  onInputStart = (e) ->

  # input end
  onInputEnd = (e) ->

  #canvas.addEventListener('', , false)

main()
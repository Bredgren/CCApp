
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

  ctx.fillStyle = "rgb(0, 0, 255)"
  ctx.fillRect(5, 5, 20, 20)

  u = new UiManager(5, 8)

  console.log("#{u.a}, #{u.b}\n")
  u.a += 5
  u.b += 5
  console.log("#{u.a}, #{u.b}\n")

main()
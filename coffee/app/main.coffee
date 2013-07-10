
DUBUG = true
if not DUBUG
  console.log = ->

main = () ->
  canvas = document.getElementById('theCanvas')
  width = window.innerWidth
  height = window.innerHeight
  canvas.width = width
  canvas.height = height
  console.log("Setting canvas size to (#{width}, #{height})")

  ctx = canvas.getContext('2d')

  clearScreen = () ->
    ctx.clearRect(0, 0, width, height)

  ### Define main page ###
  mainPage = uiManager.elementIs("main page", uiElementType.element)
  mainPage.topLeftIs(new UiPosition(0, 0))
  mainPage.bottomRightIs(new UiPosition(width, height))
  mainPage.notifieeIs('active',
    (args) ->
      if args[0]
        clearScreen()
        startWorkoutButton.activeIs(true)
        exercisesButton.activeIs(true)
      else
        clearScreen()
        startWorkoutButton.activeIs(false)
        exercisesButton.activeIs(false)
  )

  # Start workout button
  swbX = 10
  swbY = 10
  swbWidth = width - 20
  swbHeight = height / 4 - 20
  if swbHeight < 50 then swbHeight = 50
  drawSwbText = () ->
    ctx.font = "30px Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.fillText("Start Workout", swbX + swbWidth / 2, swbY + swbHeight / 2)
  drawSwbPressed = () ->
    console.log("drawing swbPressed")
    ctx.clearRect(swbX, swbY, swbWidth, swbHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    ctx.fillRect(swbX, swbY, swbWidth, swbHeight)
    ctx.strokeStyle = "rgb(255, 255, 255)"
    ctx.lineWidth = 2
    ctx.strokeRect(swbX, swbY, swbWidth, swbHeight)
    ctx.fillStyle = "rgb(255, 255, 255)"
    drawSwbText()
  drawSwbReleased = () ->
    console.log("drawing swbReleased")
    ctx.clearRect(swbX, swbY, swbWidth, swbHeight)
    ctx.strokeStyle = "rgb(0, 0, 0)"
    ctx.lineWidth = 2
    ctx.strokeRect(swbX, swbY, swbWidth, swbHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    drawSwbText()
  swbHandleActive = (args) ->
    if args[0]
      drawSwbReleased()

  startWorkoutButton = mainPage.childIs("start workout button",
                                        uiElementType.element)
  startWorkoutButton.topLeftIs(new UiPosition(swbX, swbY))
  startWorkoutButton.bottomRightIs(new UiPosition(swbX + swbWidth,
                                                  swbY + swbHeight))
  startWorkoutButton.enterActionIs(drawSwbPressed)
  startWorkoutButton.leaveActionIs(drawSwbReleased)
  startWorkoutButton.pressActionIs(drawSwbPressed)
  startWorkoutButton.releaseActionIs(() ->
    drawSwbReleased()
    console.log("deactivating main page")
    mainPage.activeIs(false)
    console.log("activating start workout page")
    swPage.activeIs(true)
  )
  startWorkoutButton.notifieeIs('active', swbHandleActive)

  # Exercises button
  ebX = swbX
  ebY = swbY + swbHeight + 10
  ebWidth = width - 20
  ebHeight = 125
  drawEbText = () ->
    title = "Exercises"
    ctx.textAlign = "center"
    ctx.textBaseline = "top"
    title_size = 20
    title_top = ebY + 10
    ctx.font = "#{title_size}px Arial"
    ctx.fillText(title, ebX + ebWidth / 2, title_top)

    size = 15
    ctx.font = "#{size}px Arial"
    ctx.textAlign = "left"
    top = title_top + title_size + 10
    left = ebX + 10
    pushups = "Pushups: #{10}"
    ctx.fillText(pushups, left, top)
    ctx.fillText("Pullups: #{10}", left,  top + size)
    ctx.fillText("Bridges: #{10}", left, top + size*2)
    ctx.fillText("Hangs: #{10}", left, top + size*3)
    ctx.fillText("Neck: #{10}", left, top + size*4)

    right = left + ctx.measureText(pushups).width + 10
    hsPushups = "Handstand Pushups: #{10}"
    if ctx.measureText(hsPushups).width + right > ebX + ebWidth
      hsPushups = "H.S. Pushups: #{10}"
    ctx.fillText("Squats: #{10}", right, top)
    ctx.fillText("Leg Raises: #{10}", right, top + size)
    ctx.fillText(hsPushups, right, top + size*2)
    ctx.fillText("Clutch Flag: #{10}", right, top + size*3)
    ctx.fillText("Calves: #{10}", right, top + size*4)
  drawEbPressed = () ->
    ctx.clearRect(ebX, ebY, ebWidth, ebHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    ctx.fillRect(ebX, ebY, ebWidth, ebHeight)
    ctx.strokeStyle = "rgb(255, 255, 255)"
    ctx.lineWidth = 2
    ctx.strokeRect(ebX, ebY, ebWidth, ebHeight)
    ctx.fillStyle = "rgb(255, 255, 255)"
    drawEbText()
  drawEbReleased = () ->
    ctx.clearRect(ebX, ebY, ebWidth, ebHeight)
    ctx.strokeStyle = "rgb(0, 0, 0)"
    ctx.lineWidth = 2
    ctx.strokeRect(ebX, ebY, ebWidth, ebHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    drawEbText()
  ebHandleActive = (args) ->
    if args[0]
      drawEbReleased()

  exercisesButton = mainPage.childIs("exercises button", uiElementType.element)
  exercisesButton.topLeftIs(new UiPosition(ebX, ebY))
  exercisesButton.bottomRightIs(new UiPosition(ebX + ebWidth, ebY + ebHeight))
  exercisesButton.enterActionIs(drawEbPressed)
  exercisesButton.leaveActionIs(drawEbReleased)
  exercisesButton.pressActionIs(drawEbPressed)
  exercisesButton.releaseActionIs(drawEbReleased)
  exercisesButton.notifieeIs('active', ebHandleActive)

  mainPage.activeIs(true)

  ### Start workout page ###
  swPage = uiManager.elementIs("start workout page", uiElementType.element)
  swPage.topLeftIs(new UiPosition(0, 0))
  swPage.bottomRightIs(new UiPosition(width, height))
  swPage.notifieeIs('active',
    (args) ->
      if args[0]
        clearScreen()
        endWorkoutButton.activeIs(true)
        workoutTitle.activeIs(true)
      else
        clearScreen()
        endWorkoutButton.activeIs(false)
        workoutTitle.activeIs(false)
  )

  # Title
  wtX = 0
  wtY = 0
  wtWidth = width
  wtHeight = 17 + 20 # height of text + padding
  drawWtText = () ->
    ctx.font = "17px Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.fillText("Pick exercises to add sets to",
      wtX + wtWidth / 2, wtY + wtHeight / 2)
  drawWt = () ->
    x = wtX - 2
    y = wtY - 2
    w = wtWidth + 4
    h = wtHeight + 4
    ctx.clearRect(x, y, w, h)
    ctx.fillStyle = "rgb(255, 255, 255)"
    ctx.fillRect(x, y, w, h)
    ctx.strokeStyle = "rgb(0, 0, 0)"
    ctx.lineWidth = 2
    ctx.strokeRect(x, y, w, h)
    ctx.fillStyle = "rgb(0, 0, 0)"
    drawWtText()
  wtHandleActive = (args) ->
    if args[0]
      drawWt()

  workoutTitle = swPage.childIs("workout title",
                                uiElementType.element)
  workoutTitle.topLeftIs(new UiPosition(wtX, wtY))
  workoutTitle.bottomRightIs(new UiPosition(wtX + wtWidth,
                                            wtY + wtHeight))
  workoutTitle.notifieeIs('active', wtHandleActive)

  # End workout button
  ewbX = 1
  ewbY = height - 20 - 20 # height of text + 10 for padding ot top and bottom
  ewbWidth = width - 2
  ewbHeight = 20 + 20 - 1 # height of text + padding
  drawEwbText = () ->
    ctx.font = "20px Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.fillText("End Workout", ewbX + ewbWidth / 2, ewbY + ewbHeight / 2)
  drawEwbPressed = () ->
    console.log("drawing EwbPressed")
    ctx.clearRect(ewbX, ewbY, ewbWidth, ewbHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    ctx.fillRect(ewbX, ewbY, ewbWidth, ewbHeight)
    ctx.strokeStyle = "rgb(255, 255, 255)"
    ctx.lineWidth = 2
    ctx.strokeRect(ewbX, ewbY, ewbWidth, ewbHeight)
    ctx.fillStyle = "rgb(255, 255, 255)"
    drawEwbText()
  drawEwbReleased = () ->
    console.log("drawing EwbReleased")
    ctx.clearRect(ewbX, ewbY, ewbWidth, ewbHeight)
    ctx.strokeStyle = "rgb(0, 0, 0)"
    ctx.lineWidth = 2
    ctx.strokeRect(ewbX, ewbY, ewbWidth, ewbHeight)
    ctx.fillStyle = "rgb(0, 0, 0)"
    drawEwbText()
  ewbHandleActive = (args) ->
    if args[0]
      drawEwbReleased()

  endWorkoutButton = swPage.childIs("end workout button",
                                    uiElementType.element)
  endWorkoutButton.topLeftIs(new UiPosition(ewbX, ewbY))
  endWorkoutButton.bottomRightIs(new UiPosition(ewbX + ewbWidth,
                                                ewbY + ewbHeight))
  endWorkoutButton.enterActionIs(drawEwbPressed)
  endWorkoutButton.leaveActionIs(drawEwbReleased)
  endWorkoutButton.pressActionIs(drawEwbPressed)
  endWorkoutButton.releaseActionIs(() ->
    drawEwbReleased()
    console.log("deactivating sw page")
    swPage.activeIs(false)
    console.log("activating m page")
    mainPage.activeIs(true))
  endWorkoutButton.notifieeIs('active', ewbHandleActive)

  # mouse down or finger down
  onInputStart = (x, y) ->
    uiManager.inputIs(new UiPosition(x, y))

  # mouse up or finger up
  onInputEnd = (x, y) ->
    uiManager.inputIs(new UiPosition(null, null))

  # move while mouse or finger down
  onInputMove = (x, y) ->
    uiManager.inputIs(new UiPosition(x, y))

  canvas.addEventListener('touchstart',
    (e) ->
      onInputStart(e.clientX, e.clientY)
    , false)

  canvas.addEventListener('touchend',
    (e) ->
      onInputEnd(e.clientX, e.clientY)
    , false)

  canvas.addEventListener('touchmove',
    (e) ->
      onInputMove(e.clientX, e.clientY)
    , false)

  ###
  dragging = false
  canvas.addEventListener('mousedown',
    (e) ->
      console.log(e)
      dragging = true
    , false)

  canvas.addEventListener('mouseup',
    (e) ->
      console.log(e)
      dragging = false
    , false)

  canvas.addEventListener('mousemove',
    (e) ->
      if dragging
        console.log(e)
    , false)
  ###

main()
## Main
#initHeader = ->
#  width = window.innerWidth
#  height = window.innerHeight
#  target =
#    x: 0
#    y: height
#
#  largeHeader = document.getElementById("masthead")
#  largeHeader.style.height = height + "px"
#  canvas = document.getElementById("masthead__canvas")
#  canvas.width = width
#  canvas.height = height
#  ctx = canvas.getContext("2d")
#
#  # create particles
#  circles = []
#  x = 0
#
#  while x < width * 0.5
#    c = new Circle()
#    circles.push c
#    x++
#  animate()
#  return
#
## Event handling
#addListeners = ->
#  window.addEventListener "scroll", scrollCheck
#  window.addEventListener "resize", resize
#  return
#
#scrollCheck = ->
#  if document.body.scrollTop > height
#    animateHeader = false
#  else
#    animateHeader = true
#  return
#
#resize = ->
#  width = window.innerWidth
#  height = window.innerHeight
#  largeHeader.style.height = height + "px"
#  canvas.width = width
#  canvas.height = height
#  return
#
#animate = ->
#  if animateHeader
#    ctx.clearRect(0, 0, width, height)
#    for i of circles
#      circles[i].draw()
#  requestAnimationFrame animate
#  return
#
## Canvas manipulation
#Circle = ->
#
#  # constructor
#  init = ->
#    _this.pos.x = Math.random() * width
#    _this.pos.y = height + Math.random() * 100
#    _this.alpha = 0.1 + Math.random() * 0.3
#    _this.scale = 0.1 + Math.random() * 0.3
#    _this.velocity = Math.random()
#    return
#  _this = this
#  (->
#    _this.pos = {}
#    init()
#    console.log _this
#    return
#  )()
#  @draw = ->
#    init()  if _this.alpha <= 0
#    _this.pos.y -= _this.velocity
#    _this.alpha -= 0.0005
#    ctx.beginPath()
#    ctx.arc _this.pos.x, _this.pos.y, _this.scale * 10, 0, 2 * Math.PI, false
#    ctx.fillStyle = "rgba(255,255,255," + _this.alpha + ")"
#    ctx.fill()
#    return
#  return
#
#width = undefined
#height = undefined
#largeHeader = undefined
#canvas = undefined
#ctx = undefined
#circles = undefined
#target = undefined
#animateHeader = true
#initHeader()
#addListeners()
#

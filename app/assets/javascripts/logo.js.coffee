animateSky= (progress)->
  red   = [0, 87,  192, 154, 0]
  green = [0, 111, 201, 35, 0]
  blue  = [0, 141, 202, 30, 0]
  if progress < 0.1
    step = 0
    range = 0.1
    before = 0
  else if progress < 0.5
    step = 1
    range = 0.4
    before = 0.1
  else if progress < 0.9
    step = 2
    range = 0.4
    before = 0.5
  else
    step = 3
    range = 0.1
    before = 0.9

  r = red[step] +  (progress - before) / range * (red[step+1] - red[step])
  g = green[step] +  (progress - before) / range * (green[step+1] - green[step])
  b = blue[step] +  (progress - before) / range * (blue[step+1] - blue[step])

  r = parseInt(r)
  g = parseInt(g)
  b = parseInt(b)

  $('.logo .sky').css 'background-color', "rgb(#{r}, #{g}, #{b})"

animateSun= (progress)->
  angle = -50  + 100 * progress
  $('.logo .sun').css 'transform', "rotate(#{angle}deg)"

animateCar= (progress)->
  left = Math.max(0, 100 * (progress-0.4)*4)
  left = Math.min(100, left)
  $('.logo .car').css 'left', "#{left}%"

animateCity= (progress)->
  left = - progress * 100
  $('.logo .city').css 'left', "#{left}%"

setLogoProgress = (progress)->
  progress = Math.max(0, progress)
  progress = Math.min(1, progress)
  animateSky progress
  animateSun progress
  animateCar progress
  animateCity progress

window.animateLogo = ->
  setLogoProgress 0.5
  height = $('.scroll-wrapper')[0].scrollHeight
  windowHeight = $(window).height()
  $('body').on 'scroll', (e)->
    progress =  - $('#content').offset().top / (height-windowHeight)
    if progress < 0
      setLogoProgress 0.5
    else
      setLogoProgress progress

window.animateLogoStatic = ->
  progress = 50
  setLogoProgress progress * 0.01
  nextFrame = ->
    progress = (progress + 0.5) % 100
    setLogoProgress progress * 0.01
    if progress == 50
      setTimeout nextFrame, 2000
    else
      setTimeout nextFrame, 50 / Math.max(Math.abs(50 - progress), 1)
  setTimeout nextFrame, 2000



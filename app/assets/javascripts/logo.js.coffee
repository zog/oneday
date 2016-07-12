window.animateLogo = ->
  animateSky= (progress)->
    red   = [87,  192, 154]
    green = [111, 201, 35]
    blue  = [141, 202, 30]
    if progress <= 0.5
      r = red[0] +  2 * progress * (red[1] - red[0])
      g = green[0] +  2 * progress * (green[1] - green[0])
      b = blue[0] +  2 * progress * (blue[1] - blue[0])
    else
      r = red[1] +  2 * (progress-0.5) * (red[2] - red[1])
      g = green[1] +  2 * (progress-0.5) * (green[2] - green[1])
      b = blue[1] +  2 * (progress-0.5) * (blue[2] - blue[1])

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
    left = - progress * 40
    $('.logo .city').css 'left', "#{left}%"

  setLogoProgress = (progress)->
    progress = Math.max(0, progress)
    progress = Math.min(1, progress)
    animateSky progress
    animateSun progress
    animateCar progress
    animateCity progress


  setLogoProgress 0
  height = $('.scroll-wrapper')[0].scrollHeight
  windowHeight = $(window).height()
  $('body').on 'scroll', (e)->
    progress =  - $('#content').offset().top / (height-windowHeight)
    setLogoProgress progress


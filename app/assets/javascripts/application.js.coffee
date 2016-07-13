#= require 'admin'
#= require 'moments'
#= require 'logo'

scrollLimit = 200
hysteresis = 20
$(document).on 'scroll', (e)->
  scroll = $('body').scrollTop()
  if $('body').hasClass('scrolled') && scroll < scrollLimit - hysteresis
    $('body').removeClass 'scrolled'
  else if ! $('body').hasClass('scrolled') && scroll > scrollLimit + hysteresis
    $('body').addClass 'scrolled'

$('.scrolled-header .logo').click ->
  $('html,body').animate({ scrollTop: 0 }, 'slow')
  false

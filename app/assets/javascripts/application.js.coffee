#= require 'admin'
#= require 'moments'
#= require 'logo'

scrollLimit = 200
hysteresis = 20
$('body').on 'scroll', (e)->
  scroll = 240 - $('.scroll-wrapper').offset().top
  if $('body').hasClass('scrolled') && scroll < scrollLimit - hysteresis
    $('body').removeClass 'scrolled'
  else if ! $('body').hasClass('scrolled') && scroll > scrollLimit + hysteresis
    $('body').addClass 'scrolled'

class window.MomentsForm
  constructor: ->
    @template = $('.new-moment').last().clone()
    @initBehaviours()
    @initButtons()
    @setSeq()
    @initMap()

  initBehaviours: ->
    $(document).on 'file:added', (e)=>
      moment = $(e.target).parents(".moment")
      @addNewMoment() if moment.hasClass "new-moment"
      moment.removeClass "new-moment"

  initMap: ->
    @map = new google.maps.Map $('#map')[0],
      zoom: 10
      center: {lat: 0, lng: 0}
    @map.addListener 'click', (e)=>
      @addMarker e

    @mapContainer = $('.map-container')
    @countrySelect = $('[name*=country]')
    @countrySelect.change =>
      @centerMap countries[@countrySelect.val()]
      @mapContainer.addClass 'open'

  addMarker: (e)->
    unless @marker
      @marker = new google.maps.Marker
        map: @map
        draggable: true
        animation: google.maps.Animation.DROP
    @marker.setPosition e.latLng
    @marker.addListener 'dragend', (e)=>
      @setLatLng e.latLng

    @setLatLng e.latLng

  setLatLng: (coords)->
    $('[name*=lat]').val coords.lat
    $('[name*=lng]').val coords.lng

  centerMap: (coords)->
    return unless coords
    bounds = new google.maps.LatLngBounds()
    bounds.extend new google.maps.LatLng(coords[0])
    bounds.extend new google.maps.LatLng(coords[1])
    @map.fitBounds bounds

  addNewMoment: ->
    newbie = @template.clone()
    id = parseInt(Math.random() * 10000)
    for el in $('[name*="[moments_attributes]["]', newbie)
      $(el).attr 'name', $(el).attr('name').replace(/\[moments_attributes\]\[\d+\]/, "[moments_attributes][#{id}]")
      prevId = $(el).attr('id')
      newId = prevId.replace(/\moments_attributes_\d+_/, "moments_attributes_#{id}_")
      $(el).attr 'id', newId
      $("[for=#{prevId}]", newbie).attr 'for', newId
    newbie.addClass "new-moment"
    newbie.insertAfter $('.new-moment').last()
    $(document).trigger 'nested:fieldAdded'
    @initButtons()
    @setSeq()

  initButtons: ->
    $('.moment').find(".remove").click (e)->
      btn = $(e.currentTarget)
      moment = btn.parents('.moment')
      e.preventDefault()
      btn.addClass 'disabled'
      moment.addClass 'disabled'
      moment.find("[name*=destroy]").val "1"
      false

  setSeq: ->
    i = 0
    for e in $('[name*=seq]')
      $(e).val i
      i += 1


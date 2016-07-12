class window.MomentsForm
  constructor: ->
    @template = $('.new-moment').last().clone()
    @initBehaviours()
    @initButtons()

  initBehaviours: ->
    $(document).on 'file:added', (e)=>
      moment = $(e.target).parents(".moment")
      @addNewMoment() if moment.hasClass "new-moment"
      moment.removeClass "new-moment"


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

  initButtons: ->
    $('.moment').find(".remove").click (e)->
      btn = $(e.currentTarget)
      moment = btn.parents('.moment')
      e.preventDefault()
      btn.addClass 'disabled'
      moment.addClass 'disabled'
      moment.find("[name*=destroy]").val "1"
      false


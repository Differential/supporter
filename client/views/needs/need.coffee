Template.need.helpers 
  offers: ->
    Offers.find(needId: @_id)

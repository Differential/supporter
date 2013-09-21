Template.need.helpers
  offers: ->
    Offers.find( {needId: @_id},
      {sort: { createdAt: -1 }}
    )

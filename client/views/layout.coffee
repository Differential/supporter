Template.layout.helpers
  mine: -> Session.get('myNeeds')

Template.layout.events
  "click #showMyNeeds": (event) ->
    event.preventDefault()
    Session.set('myNeeds', true)

  "click #showAllNeeds": (event) ->
    event.preventDefault()
    Session.set('myNeeds', false)

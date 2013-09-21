Template.layout.helpers
  mine: -> Session.get('myNeeds')

Template.layout.events
  "click #showMyNeeds": (event) ->
    event.preventDefault()
    Router.go('needs')
    Session.set('myNeeds', true)

  "click #showAllNeeds": (event) ->
    event.preventDefault()
    Router.go('needs')
    Session.set('myNeeds', false)

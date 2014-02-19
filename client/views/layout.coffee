Template.layout.rendered = ->

  if Router.current().path is '/profile'
    Session.set('currentSection', 'profile')

  $('.navbar-default a').parent().removeClass('active')
  $('.'+ Session.get('currentSection') + 'Link').parent().addClass('active')

Template.layout.events
  "click .navbar-brand": (event) ->
    event.preventDefault()
    Router.go('/')
    Session.set('currentSection', 'allNeeds')

  "click .myNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/mine')
    Session.set('currentSection', 'myNeeds')

  "click .allNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/')
    Session.set('currentSection', 'allNeeds')

  "click .topNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/')
    Session.set('currentSection', 'topNeeds')
    
  "click .starNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/fav')
    Session.set('currentSection', 'strNeeds')

  "click .backgroundsLink": (event) ->
    event.preventDefault()
    Router.go('/backgrounds')
    Session.set('currentSection', 'backgrounds')

  'keyup #query': (event) ->
    event.preventDefault()
    query = $(event.target).val()
    Session.set('query', query)

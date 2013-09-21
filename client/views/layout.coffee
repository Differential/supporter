Template.layout.rendered = ->

  if Router.current().path is '/profile'
    Session.set('currentSection', 'profile')

  $('.navbar-default a').parent().removeClass('active')
  $('.'+ Session.get('currentSection') + 'Link').parent().addClass('active')

Template.layout.events
  "click .myNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/mine')
    Session.set('currentSection', 'myNeeds')

  "click .allNeedsLink": (event) ->
    event.preventDefault()
    Router.go('/')
    Session.set('currentSection', 'allNeeds')

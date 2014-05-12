Template.needs.query = ->
  Session.get('query')

Template.needs.events {
  'click #clear-query': (e) ->
    e.preventDefault()
    Session.set('query', '')
    Router.go('needs')
}

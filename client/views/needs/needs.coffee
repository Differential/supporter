Template.needs.query = ->
  Session.get('query')

Template.needs.helpers
  isSubscribed: ->
    Session.get('query') in Meteor.user().profile.subscriptions

Template.needs.events {
  'click #clear-query': (e) ->
    e.preventDefault()
    Session.set('query', '')
    Router.go('needs')

  'click #subscribe': (e) ->
    e.preventDefault()
    console.log 'called'
    Meteor.call 'addSubscription', Meteor.userId(), Session.get('query')

  'click #unsubscribe': (e) ->
    e.preventDefault()
    console.log 'called'
    Meteor.call 'removeSubscription', Meteor.userId(), Session.get('query')
}

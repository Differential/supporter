Meteor.startup ->
  Session.set('chars', 0)

Meteor.subscribe('needs')

Meteor.subscribe('offers')

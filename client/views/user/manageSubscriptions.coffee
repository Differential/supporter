Template.manage.helpers
  tags: ->
    Meteor.user().profile.subscriptions
  watchedCards: ->
    Needs.find(_id: { $in: Meteor.user().profile.watching})
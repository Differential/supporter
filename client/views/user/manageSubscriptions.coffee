Template.manage.helpers
  tags: ->
    Meteor.user().profile.subscriptions

Template.manage.events
  'click .rm-tag': (e) ->

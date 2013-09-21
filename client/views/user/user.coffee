Template.user.helpers
  owner: ->
    Meteor.userId() is @userId

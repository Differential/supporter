Template.sendNeed.helpers
  url: Meteor.absoluteUrl('')
  _id: ->
    Needs.findOne()._id

Template.sendNeed.events
  "click .cancel": ->
    Session.set('sendingTo', null)

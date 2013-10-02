Template.sendNeed.rendered = ->
  addthis.toolbox ".addthis_toolbox"

Template.sendNeed.helpers
  url: Meteor.absoluteUrl('')

Template.sendNeed.events
  "click .cancel": ->
    Session.set('sendingTo', null)

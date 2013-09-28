Template.needListing.rendered = ->
  $('a').tooltip
    placement: 'bottom'
    container: 'body'

Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username
  involved: ->
    Meteor.user() && Meteor.user().username == @username || Meteor.user() && Offers.findOne({username:Meteor.user().username, needId: @_id})

Template.needListing.helpers
  sending: ->
    Session.equals('sendingTo', @_id)

  editing: ->
    Session.equals('respondingTo', @_id)

  loggedIn: ->
    Meteor.user()

Template.needListing.events
  'click .delete': ->
    Needs.remove(@_id)

  'click .complete': ->
    Needs.update(@_id, $set: {completedAt: new Date()})

  "click .respond": ->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)

  "click .send": ->
    Session.set('sendingTo', @_id)

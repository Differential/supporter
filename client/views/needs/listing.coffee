Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username
  involved: ->
    Meteor.user() && Meteor.user().username == @username || Meteor.user() && Offers.findOne({username:Meteor.user().username, needId: @_id})

Template.needListing.helpers
  editing: ->
    Session.equals('editing_itemname', @_id)

Template.needListing.events
  'click .delete': ->
    Needs.remove(@_id)

  'click .complete': ->
    Needs.update(@_id, $set: {completedAt: new Date()})

  "click .respond": ->
    Session.set('editing_itemname', @_id)

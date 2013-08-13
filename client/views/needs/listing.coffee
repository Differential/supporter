Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username

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

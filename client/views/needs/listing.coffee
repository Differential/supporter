Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username

Template.needListing.helpers
  editing: ->
    Session.equals('editing_itemname', @_id)

Template.needListing.events
  'click .delete': ->
    Needs.remove(@_id)


Template.needListing.events
  "click .btn": ->
    Session.set('editing_itemname', @_id)

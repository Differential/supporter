Template.needStub.helpers
  owner: ->
    Meteor.userId() is @userId

Template.needStub.events
  'click .delete': (event)->
    Needs.update(@_id, $set: {backgroundId: ""})

  'click .select': (event)->
      Needs.update(@_id, $set: {backgroundId: $(event.target).data('id')})
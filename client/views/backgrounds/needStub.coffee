Template.needStub.helpers
  owner: ->
    Meteor.userId() is @userId

Template.needStub.events
  'click .delete': (event)->
    Needs.update(@_id, $set: {backgroundId: ""})

  'click .select': (event)->
      console.log $(event.currentTarget).attr('div.panel-heading')
    ##  Needs.update(@_id, $set: {backgroundId: @_id})
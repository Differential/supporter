Template.needStub.helpers
  editing: ->
    Needs.findOne({_id: @_id, backgroundId: Session.get('editingProject')})

Template.backgroundListing.events
  'click .rmNeedBtn': (event)->
    Needs.update(@_id, $set:{backgroundId: null})
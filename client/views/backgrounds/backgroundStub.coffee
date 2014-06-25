Template.backgroundStub.helpers
  hasNeeds: ->
    Needs.find({backgroundId: @_id}).count() > 0
  needs: ->
    Needs.find({backgroundId: @_id})
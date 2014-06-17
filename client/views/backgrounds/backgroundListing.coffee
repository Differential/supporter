Template.backgroundListing.helpers
  owner: ->
    Meteor.userId() is @userId
  backgrounds: ->
    Backgrounds.find({})
  needs: ->
    Needs.find backgroundId: @_id
  needsIOwn: ->
    Needs.find userId: Meteor.user._id
  isEditingProject: ->
    Session.get('editingProject') is @_id
  editFlagForNeeds: ->
    return _.extend({editingFlag: Session.get('editingProject') is @_id},this);


Template.backgroundListing.events
  'click .delete': (event)->
    Backgrounds.remove(@_id)

  'click .complete': (event)->
    Backgrounds.update(@_id, $set: {completedAt: new Date()})

  "click .saveBackgroundBtn": (event, template)->
    desc = $(template.find('textarea#editProjectDescription')).val()
    nm = $(template.find('input#editProjectName')).val()
    Backgrounds.update(@_id, $set: {description : desc})
    Backgrounds.update(@_id, $set: {name : nm})
    Session.set('editingProject', null)

  "click .addNeedToBackgroundBtn": (event, template)->
    need = $(template.find('select#needsToAdd')).val()
    Needs.update(need, $set: {backgroundId: Session.get('editingProject')})

  "click .editBackgroundBtn": (event, template)->
    Session.set('editingProject', @_id)
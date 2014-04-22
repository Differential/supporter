Template.needListing.rendered = ->
  $('a').tooltip
    placement: 'bottom'

  $('a').on('click', ->
    $(@).tooltip('destroy')
  )

Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username
  showStarred: ->
    Meteor.user() && Meteor.user().username != @username
  starred: ->
    #if Meteor.user()
    Meteor.user() && Needs.findOne({_id: @_id}).starUsers and
      Needs.findOne({_id: @_id}).starUsers.length > 0 and
      Meteor.user()._id in Needs.findOne({_id: @_id}).starUsers
  hasBackground: ->
    console.log @_id
    Needs.findOne({_id: @_id}) && Needs.findOne({_id: @_id}).backgroundId
  backgroundTitle: ->
    if Needs.findOne({_id: @_id}).backgroundId != null
      backgroundId = Needs.findOne({_id: @_id}).backgroundId
      console.log backgroundId
      Backgrounds.findOne({_id: backgroundId}).name
  backgroundId: ->
    if Needs.findOne({_id: @_id}) != null
      Needs.findOne({_id: @_id}).backgroundId


Template.needListing.events
  'click .delete': (event)->
    Needs.remove(@_id)

  'click .complete': (event)->
    Needs.update(@_id, $set: {completedAt: new Date()})

  "click .respond": (event, template)->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)
    $(template.find('.newOffer')).modal()

  "click .send": (event, template)->
    Session.set('sendingTo', @_id)
    $(template.find('.sendNeed')).modal()

  "click .editNeedBtn": (event, template)->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)
    $(template.find('.editNeed')).modal()

  "click .star": (event, template)->
    stars = Needs.find ({_id:@_id,  starUsers: { $in: [Meteor.user()._id] }}  )
    alreadyStar = stars and stars.count() > 0
    #starCount = Needs.find({_id:@_id}, { array: { $elemMatch: { starUser: Meteor.user()._id }}}).count()
    #starCount = Needs.find( {_id:@id}, { array: { $elemMatch: { starUser: Meteor.user()._id }}}).Count
    if alreadyStar
      #TODO remove this need to user's list
      Needs.update(@_id, {$pull: {starUsers: Meteor.user()._id}})
      Needs.update(@_id,  {$inc: {starCount: -1}})
    else
      #TODO Add this need to user's list
      Needs.update(@_id,  {$inc: {starCount: 1}})
      Needs.update(@_id, {$push: {starUsers: Meteor.user()._id}})
    Meteor.call("updateScore", @, true)

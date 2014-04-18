Template.backgroundListing.helpers
  owner: ->
    Meteor.userId() is @userId

Template.backgroundListing.helpers
  backgrounds: ->
    Backgrounds.find({})

Template.backgroundListing.helpers
  needs: ->
    Needs.find({userId: Meteor.userId()})


Template.backgroundListing.events
  'click .delete': (event)->
    Backgrounds.remove(@_id)

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

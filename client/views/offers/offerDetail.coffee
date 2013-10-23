Template.offerDetail.helpers
  allowedToView: ->
    #Owner of offer or owner of need
    Meteor.user() && Meteor.user().username == @username || Meteor.user() && Needs.findOne({userId:Meteor.user()._id, _id: @needId})
  editingOffer: ->
    Session.get('editingOffer') == @_id
  offerOwner: ->
    Meteor.user() && Meteor.user().username == @username
  
Template.offerDetail.events
  "click .editOfferButton": (event, template)->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)
    $(template.find('.editOffer')).modal()
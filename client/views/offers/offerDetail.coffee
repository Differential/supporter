Template.offerDetail.helpers
  allowedToView: ->
    #Owner of offer or owner of need
    Meteor.user() && Meteor.user().username == @username || Meteor.user() && Needs.findOne({userId:Meteor.user()._id, _id: @needId})
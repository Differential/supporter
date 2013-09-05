Template.needs.helpers
	needs: ->
    if Session.get('myNeeds', true)
      Needs.find({userId: Meteor.userId()}, sort: {createdAt: -1})
    else
      Needs.find()
Template.needs.helpers
	needs: ->
    if Session.get('myNeeds', true)
      Needs.find({userId: Meteor.userId()})
    else
      Needs.find({completedAt: {$exists: false}})
Template.needs.helpers
	needs: ->
    if Session.get('myNeeds', true)
      Needs.find({userId: Meteor.userId()})
    else
      Needs.find({completedAt: {$exists: false}})

      
Template.needs.events
  "click input#showMyNeeds": ->
    Session.set('myNeeds', true)
  "click input#showAllNeeds": ->
    Session.set('myNeeds', false)
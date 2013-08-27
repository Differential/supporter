Template.needs.helpers
	needs: ->
    if Session.get('mineOnly', true)
      Needs.find({completedAt: {$exists: false}})
    else
      Needs.find({completedAt: {$exists: false}})

Template.needs.preserve('.need')

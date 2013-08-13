Template.needs.helpers
	needs: ->
    Needs.find({completedAt: {$exists: false}})

Template.needs.preserve('.need')

Template.backgrounds.helpers
  backgrounds: ->
    Backgrounds.find userId: Meteor.userId()

Template.backgrounds.helpers
  needs: ->
    Needs.find({})

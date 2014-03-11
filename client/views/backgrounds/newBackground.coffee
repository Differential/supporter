Template.newBackground.events

  'click button': (e)->
    Backgrounds.insert
      name: $('input[name="name"]').val()
      description: $('textarea[name="description"]').val()
      userId: Meteor.userId()
      username: Meteor.user().username
      createdAt: new Date()

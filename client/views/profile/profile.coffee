Template.profile.rendered = ->
  $('#bio').keydown( (event) ->
    if event.keyCode == 13
      $('#bio').blur()
  )

Template.profile.helpers

  name: ->
    Meteor.user().profile.name

  organization: ->
    Meteor.user().profile.organization

  bio: ->
    Meteor.user().profile.bio

  url: ->
    Meteor.user().profile.url

Template.profile.events
  'change #name': (event) ->
    Meteor.users.update(Meteor.userId(), {
      $set: {
        'profile.name': $(event.target).val()
      }
    })

  'change #organization': (event) ->
    Meteor.users.update(Meteor.userId(), {
      $set: {
        'profile.organization': $(event.target).val()
      }
    })

  'change #bio': (event) ->
    Meteor.users.update(Meteor.userId(), {
      $set: {
        'profile.bio': $(event.target).val()
      }
    })

  'change #url': (event) ->
    Meteor.users.update(Meteor.userId(), {
      $set: {
        'profile.url': $(event.target).val()
      }
    })

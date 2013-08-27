Template.newNeed.helpers
  chars: ->
    Session.get('chars')

  charLengthClass: ->
    if Session.get('chars') < 30 || Session.get('chars') > 200
      'red'
    else
      ''
  charLengthMessage: ->
    message = ''
    if Session.get('chars') < 30
      message = '(be more descriptive)'
    if Session.get('chars') > 200
      message = '(be less descriptive)'

    message

addNeed = ->
  console.log 'hi'
  user = Meteor.user()
  if user and user.username
    newNeed = $('#newNeed').val()
    if newNeed.length > 30
      if newNeed.length < 200
        Session.set('chars', 0)
        $('#newNeed').val ''
        Needs.insert
          content: newNeed
          createdAt: new Date()
          userId: Meteor.userId()
          username: user.username
          offerCount: 0
      else
        alert 'Be less descriptive'
    else
      alert 'Be more descriptive'

Template.newNeed.events
  "click input#newNeedButton": ->
    addNeed()

  "keyup textarea#newNeed": (evt) ->
    Session.set('chars', $('textarea#newNeed').val().length)


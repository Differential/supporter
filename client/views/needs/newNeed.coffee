addNeed = ->
  console.log 'hi'
  user = Meteor.user()
  if user and user.username
    newNeed = $('#newNeed').val()
    if newNeed.length > 30
      $('#newNeed').val ''
      Needs.insert
        content: newNeed
        createdAt: new Date()
        userId: user._Id
        username: user.username
        offerCount: 0
    else
      alert 'Be more descriptive'

Template.newNeed.events
  "click input#newNeedButton": ->
    addNeed()

  "keypress input#newNeed": (evt) ->
    addNeed() if evt.which is 13

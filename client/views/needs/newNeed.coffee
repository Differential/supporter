Template.newNeed.rendered = ->
  $('#tags').select2({tags:["mentoring", "funding"]})

Template.newNeed.helpers
  chars: ->                 Session.get('chars')
  showCharLengthMessage: -> Session.get('chars') > 0

  charLengthClass: ->
    if Session.get('chars') < 30 || Session.get('chars') > 200
      'red'
    else
      ''
  saveButtonClass: ->
    if Session.get('chars') < 30 || Session.get('chars') > 200
      'hidden'
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
  user = Meteor.user()
  if user and user.username
    newNeed = $('#newNeed').val()
    if newNeed.length >= 30
      if newNeed.length <= 200
        Session.set('chars', 0)
        $('#newNeed').val ''
        Needs.insert
          content: newNeed
          createdAt: new Date()
          userId: Meteor.userId()
          username: user.username
          offerCount: 0
          score: Supporter.computeScore({stars: 0, createdAt: new Date()})
          tags: $('#tags').val().split(",")
          backgroundId: $('#backgroundId').val()
          backgroundName: Backgrounds.findOne($('#backgroundId').val()).name
        , ->
          Router.go('needs')
      else
        alert 'Be less descriptive'
    else
      alert 'Be more descriptive'

updateChars = ->
  Session.set('chars', $('textarea#newNeed').val().length)

Template.newNeed.events
  "click input#newNeedButton": (e) ->
    addNeed()

  "keyup textarea#newNeed": (e)->
    _.debounce(updateChars, 3000)()

Template.newOffer.helpers
  chars: ->
    Session.get('charsOffer')

  showCharLengthMessage: ->
    Session.get('charsOffer') > 0

  charLengthClass: ->
    if Session.get('charsOffer') < 30 || Session.get('charsOffer') > 200
      'red'
    else
      ''
  charDisableSubmit: ->
    Session.get('charsOffer') < 30 || Session.get('charsOffer') > 200

  charLengthMessage: ->
    message = ''
    if Session.get('charsOffer') < 30
      message = '(be more descriptive)'
    if Session.get('charsOffer') > 200
      message = '(be less descriptive)'

    message


addOffer = ->
  user = Meteor.user()
  if user and user.username
    newOffer = $('#newOffer').val()
    if newOffer.length > 30
      $('#newOffer').val ''
      needOwnerId = Needs.findOne({_id: Session.get('respondingTo')}).userId
      offerId = Offers.insert
        content: newOffer
        createdAt: new Date()
        userId: user._id
        username: user.username
        email: user.emails[0].address
        needId: Session.get('respondingTo')
        needOwnerId: needOwnerId

      Needs.update(Session.get('respondingTo'), {$inc: {offerCount: 1}})

      Meteor.defer ->
        Meteor.call('notifyOffer', offerId)

    else
      alert 'Be more descriptive'

Template.newOffer.events
  "click .newOfferButton": ->
    addOffer()
    Session.set('respondingTo',null)
    Session.set('charsOffer', null)

  "keypress input#newOffer": (evt) ->
    addOffer() if evt.which is 13

  "click .cancel": ->
    Session.set('respondingTo', null)
    Session.set('charsOffer', null)

  "keyup textarea#newOffer": (evt) ->
    Session.set('charsOffer', $('textarea#newOffer').val().length)

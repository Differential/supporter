Template.editOffer.helpers
  chars: ->
    Session.get('charsOffer')

  showCharLengthMessage: ->
    Session.get('charsOffer') > 0

  charLengthClass: ->
    if Session.get('charsOffer') < 10 || Session.get('charsOffer') > 200
      'has-error'
    else
      ''
  charDisableSubmit: ->
    Session.get('charsOffer') < 10 || Session.get('charsOffer') > 200

  charLengthMessage: ->
    message = ''
    if Session.get('charsOffer') < 10
      message = '(be more descriptive)'
    if Session.get('charsOffer') > 200
      message = '(be less descriptive)'
    message

editOffer = (el)->
  user = Meteor.user()
  if user and user.username
    newOffer = el.val()
    if newOffer.length >= 10
      el.val ''
      Offers.update(Session.get('respondingTo'), {$set: {content:newOffer}})
      needId = Offers.findOne({_id: Session.get('respondingTo')}).needId
      Meteor.call 'notifyOffer', Session.get('respondingTo'), true
      Meteor.defer ->
        Router.go('need', {_id: needId})
        $('.modal').modal('hide')
        $('body').removeClass('modal-open')
        $('.modal-backdrop').remove()
    else
      alert 'Be more descriptive'

Template.editOffer.events
  "click .editOfferButton": (event, template)->
    editOffer $(template.find('textarea#newOffer'))
    Session.set('charsOffer', null)

  "click .cancel": (event)->
    Session.set('charsOffer', null)

  "keyup textarea#newOffer": (event, template)->
    Session.set('charsOffer', $(template.find('textarea#newOffer')).val().length)

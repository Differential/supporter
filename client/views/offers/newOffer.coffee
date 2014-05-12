Template.newOffer.rendered = ->
  $(@firstNode).parent().parent().parent().css('z-index', '999')

Template.newOffer.helpers
  chars: ->
    Session.get('charsOffer')

  showCharLengthMessage: ->
    Session.get('charsOffer') > 0

  charLengthClass: ->
    if Session.get('charsOffer') < 10 || Session.get('charsOffer') > 200
      'has-error'
    else
      ''

  saveButtonClass: ->
    if Session.get('charsOffer') < 10 || Session.get('charsOffer') > 200
      'hidden'
    else
      ''

  charLengthMessage: ->
    message = ''
    if Session.get('charsOffer') < 10
      message = '(be more descriptive)'
    if Session.get('charsOffer') > 200
      message = '(be less descriptive)'
    message

addOffer = (el)->
  user = Meteor.user()
  if user and user.username
    newOffer = el.val()
    if newOffer.length >= 10
      el.val ''
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

      Meteor.call('notifyOffer', offerId)

      $('.modal').modal('hide')
      $('body').removeClass('modal-open')

      Meteor.defer ->
        Router.go('/need/' + Session.get('respondingTo'))
        Session.set('currentSection', 'need')
    else
      alert 'Be more descriptive'

Template.newOffer.events
  "click .newOfferButton": (event, template)->
    addOffer $(template.find('textarea#newOffer'))
    Session.set('charsOffer', null)

  "click .cancel": (event)->
    Session.set('charsOffer', null)
    Session.set('replyId', null)

  "keyup textarea#newOffer": (event, template)->
    Session.set('charsOffer', $(template.find('textarea#newOffer')).val().length)

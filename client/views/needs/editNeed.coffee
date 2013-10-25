Template.editNeed.helpers
  chars: ->
    Session.get('chars')

  showCharLengthMessage: ->
    Session.get('chars') > 0

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

editNeed = (el) ->
  user = Meteor.user()
  if user and user.username
    newNeed = el.val()
    if newNeed.length >= 30
      if newNeed.length <= 200
        Session.set('chars', 0)
        $('#editNeedContent').val ''
        Needs.update(@Session.get('respondingTo'), {$set: {content: newNeed}})
        Meteor.defer ->
          $('.modal').modal('hide')
          $('body').removeClass('modal-open')
          $('.modal-backdrop').remove()
      else
        alert 'Be less descriptive'
    else
      alert 'Be more descriptive'

Template.editNeed.events
  'click .editNeedButton': (evt, template) ->
    editNeed $(template.find('textarea#editNeedContent'))
    Session.set('charsOffer', null)

  'keyup textarea#editNeedContent': (evt) ->
    Session.set('chars', $('textarea#editNeedContent').val().length)

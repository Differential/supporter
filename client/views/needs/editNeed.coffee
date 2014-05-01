Template.editNeed.rendered = ->
  $('#edit-tags').select2({tags: ['Mentoring', 'Financing']})
  Session.set 'editChars', $('textarea#editNeedContent').val().length
  $(@firstNode).parent().parent().parent().css('z-index', '999')

Template.editNeed.helpers
  chars: ->
    Session.get('editChars')

  showCharLengthMessage: ->
    Session.get('editChars') > 0

  charLengthClass: ->
    if Session.get('editChars') < 30 || Session.get('editChars') > 200
      'red'
    else
      ''

  saveButtonClass: ->
    if Session.get('editChars') < 30 || Session.get('editChars') > 200
      'hidden'
    else
      ''

  charLengthMessage: ->
    message = ''
    if Session.get('editChars') < 30
      message = '(be more descriptive)'
    if Session.get('editChars') > 200
      message = '(be less descriptive)'
    message

Template.editNeed.events
  'click .editNeedButton': (evt, template) ->
    content = $(template.find('textarea#editNeedContent')).val()
    tags = $(template.find('#edit-tags')).val().split(",")

    if content.length >= 30
      if content.length <= 200
        Session.set('editChars', 0)
        Needs.update @_id, { $set: {content: content, tags: tags} }
      else
        alert 'Be less descriptive'
    else
      alert 'Be more descriptive'

    Session.set 'editId', null

  'keyup textarea#editNeedContent': (evt, template) ->
    Session.set('editChars', $(template.find('textarea#editNeedContent')).val().length)

  'click .cancel': (evt) ->
    Session.set 'editId', null

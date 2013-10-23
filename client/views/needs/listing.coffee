Template.needListing.rendered = ->
  $('a').tooltip
    placement: 'bottom'

  $('a').on('click', ->
    $(@).tooltip('destroy')
  )

Template.needListing.helpers
  owner: ->
    Meteor.user() && Meteor.user().username == @username

Template.needListing.events
  'click .delete': (event)->
    Needs.remove(@_id)

  'click .complete': (event)->
    Needs.update(@_id, $set: {completedAt: new Date()})

  "click .respond": (event, template)->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)
    $(template.find('.newOffer')).modal()

  "click .send": (event, template)->
    Session.set('sendingTo', @_id)
    $(template.find('.sendNeed')).modal()
    
  "click .editNeedBtn": (event, template)->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)
    $(template.find('.editNeed')).modal()

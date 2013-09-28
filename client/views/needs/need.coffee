Template.need.rendered = ->
  $('a').tooltip
    placement: 'bottom'
  $('a').on('click', ->
    $(@).tooltip('destroy')
  )

Template.need.helpers
  offers: ->
    Offers.find(
      {needId: @_id},
      {sort: { createdAt: -1 }}
    )

  owner: ->
    Meteor.user() && Meteor.user().username == @username

  sending: ->
    Session.equals('sendingTo', @_id)

  editing: ->
    Session.equals('respondingTo', @_id)

Template.need.events
  'click .delete': ->
    Needs.remove(@_id)

  'click .complete': ->
    Needs.update(@_id, $set: {completedAt: new Date()})

  "click .respond": ->
    Session.set('respondingTo', @_id)
    Session.set('charsOffer', null)

  "click .send": ->
    Session.set('sendingTo', @_id)

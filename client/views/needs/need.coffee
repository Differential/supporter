Template.need.rendered = ->
  $('a').tooltip
    placement: 'bottom'
  $('a').on('click', ->
    $(@).tooltip('destroy')
  )

Template.need.helpers
  offers: ->
    Offers.find({}, {sort: {createdAt: -1}})
  owner: ->
    Meteor.user() && Meteor.user().username == @username
  content: ->
    Needs.findOne().content
  offerCount: ->
    Needs.findOne().offerCount
  createdAt: ->
    Needs.findOne().createdAt
  isReplying: ->
    Session.get('replyId') is @_id

Template.need.events
  'click .delete': (event)->
    Needs.remove(Needs.findOne()._id)
    Router.go('/')

  'click .complete': (event)->
    Needs.update(Needs.findOne()._id, $set: {completedAt: new Date()})
    Router.go('/')

  "click .respond": (event, template)->
    Session.set('respondingTo', Needs.findOne()._id)
    Session.set('charsOffer', null)
    Session.set('replyId', @_id)

  "click .send": (event, template)->
    Session.set('sendingTo', Needs.findOne()._id)
    $(template.find('.sendNeed')).modal()


Template.manage.helpers
  tags: ->
    Meteor.user().profile.subscriptions
  watchedCards: ->
    if Meteor.user().profile.watching
      Needs.find(_id: { $in: Meteor.user().profile.watching})
  hasCards: ->
    Meteor.user().profile.watching
  isNow: ->
    Meteor.user().profile.frequency is 0
  isDaily: ->
    Meteor.user().profile.frequency is 1
  isWeekly: ->
    Meteor.user().profile.frequency is 7
  isMonthly: ->
    Meteor.user().profile.frequency is 30
  isNever: ->
    Meteor.user().profile.frequency is 99

Template.manage.events
  'click .now': (event, template) ->
    Meteor.call 'setFrequency', Meteor.userId(), 0
  'click .daily': (event, template) ->
    Meteor.call 'setFrequency', Meteor.userId(), 1
  'click .weekly': (event, template) ->
    Meteor.call 'setFrequency', Meteor.userId(), 7
  'click .monthly': (event, template) ->
    Meteor.call 'setFrequency', Meteor.userId(), 30
  'click .never': (event, template) ->
    Meteor.call 'setFrequency', Meteor.userId(), 99
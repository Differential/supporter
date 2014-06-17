Template.tagStub.events
  'click .rmTagBtn': (event, template) ->
    tag = template.data
    event.preventDefault()
    Meteor.call 'removeSubscription', Meteor.userId(), tag
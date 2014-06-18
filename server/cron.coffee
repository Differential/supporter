Meteor.setInterval ->
  Meteor.call 'sendSubscriptions', false
, 1000*300 #5 min

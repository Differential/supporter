Meteor.setInterval ->
  Meteor.call 'sendSubscriptions'
, 1000*3600 #hourly

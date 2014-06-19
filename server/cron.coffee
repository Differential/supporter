Meteor.setInterval ->
  Meteor.call 'sendSubscriptions', false
, 1000*3600 #hourly

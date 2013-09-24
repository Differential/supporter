Meteor.publish "needs", ->
  Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}

Meteor.publish "offers", ->
  if @userId
    return Offers.find {}
  else
    return @.stop()


Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

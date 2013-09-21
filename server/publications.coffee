Meteor.publish "needs", ->
  Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}

Meteor.publish "offers", ->
  if @userId
    return Offers.find {userId: @userId}
  else
    return @.stop()

Meteor.publish "offersToMyNeeds", ->
  if @userId
    return Offers.find {needOwnerId: @userId}
  else
    return @.stop()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

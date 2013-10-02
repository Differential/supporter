Meteor.publish "needs", (query) ->
  if query
    Needs.find({completedAt: {$exists: false}, content: {$regex: query, $options: 'i'}}, {sort: {createdAt: -1}, limit: 50})
  else
    Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}

Meteor.publish "offers", ->
  Offers.find()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

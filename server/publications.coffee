Meteor.publish "needs", (query) ->
  if query
    Needs.find({completedAt: {$exists: false}, content: {$regex: query, $options: 'i'}}, {sort: {starCount: -1, createdAt: -1}, limit: 50})
  else
    Needs.find {completedAt: {$exists: false}}, sort: {starCount: -1, createdAt: -1}

Meteor.publish "userNeeds", (username) ->
  Needs.find {username: username, completedAt: {$exists: false}}, sort: {starCount: -1, createdAt: -1}

Meteor.publish "offers", ->
  Offers.find()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

Meteor.publish "needs", (query) ->
  if query
    Needs.find({completedAt: {$exists: false}, content: {$regex: query, $options: 'i'}}, {sort: {score: 1}, limit: 30})
  else
    Needs.find {completedAt: {$exists: false}}, sort: {score: 1}, limit: 30

Meteor.publish "userNeeds", (username) ->
  Needs.find {username: username, completedAt: {$exists: false}}, sort: {score: 1}

Meteor.publish "offers", ->
  Offers.find()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

Meteor.publish "backgrounds", ->
  Backgrounds.find()

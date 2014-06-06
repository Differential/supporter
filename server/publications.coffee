Meteor.publish "needs", (query) ->
  if query
    Needs.find {completedAt: {$exists: false},  $or: [ { content: {$regex: query, $options: 'i'} }, { tags: { $in: [ query ] } } ] }, {sort: {score: -1}}
  else
    Needs.find {completedAt: {$exists: false}}, {sort: {score: -1}}

Meteor.publish "userNeeds", ->
  Needs.find {userId: @userId, completedAt: {$exists: false}}, {sort: {score: -1}}

Meteor.publish "offers", ->
  Offers.find()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

Meteor.publish "backgrounds", ->
  Backgrounds.find()

Meteor.publish "need", (id) ->
  Needs.find(id)

Meteor.publish "offersForNeed", (offerId) ->
  Offers.find(needId: offerId)

Meteor.publish 'admins', ->
  Roles.getUsersInRole 'admin'

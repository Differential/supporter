Meteor.publish "needs", (query) ->
  if query
    console.log query
  else
    Needs.find {completedAt: {$exists: false}}, {sort: {score: -1}}



Meteor.publish "userNeeds", (username) ->
  Needs.find {username: username, completedAt: {$exists: false}}, {sort: {score: -1}}

Meteor.publish "offers", ->
  Offers.find()

Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

Meteor.publish "backgrounds", ->
  Backgrounds.find()

Meteor.publish "need", (id) ->
  Needs.find(id)

Meteor.publish "offersForNeed", (offerId) ->
  Offers.find(offerId: offerId)

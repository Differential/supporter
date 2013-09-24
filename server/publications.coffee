Meteor.publish "needs", (query) ->
  if query
    Needs.find({content: {$regex: query, $options: 'i'}}, {sort: {createdAt: -1}, limit: 50})
    #Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}
  else
    Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}
    
Meteor.publish "offers", ->
  if @userId
    return Offers.find {}
  else
    return @.stop()


Meteor.publish "user", (username) ->
  Meteor.users.find(username: username)

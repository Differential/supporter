count = Needs.find().count()

Meteor.publish "needs", ->
  Needs.find {completedAt: {$exists: false}}, sort: {createdAt: -1}

Meteor.publish "offers", ->
  Offers.find {userId: @id}
  
Needs.allow
  insert: (userId, doc) ->
    userId

  update: (userId, doc) ->
    userId
  
Meteor.defer ->
  if count is 0
    now = new Date()

    #create Users
    userId = Accounts.createUser(
      username: 'foo'
      password: 'foo'
      email: 'foo@bar.com'
    )

    #create Needs
    need = Needs.insert(
      content: 'Help'
      createdAt: now
      userId: userId
      username: 'foo'
      offerCount: 0
    )
    
    offer = Offers.insert(
      content: 'reply'
      createdAt: now
      userId: userId
      username: 'foo'
      needId: need
    )
    
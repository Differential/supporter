count = Needs.find().count()

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
    )
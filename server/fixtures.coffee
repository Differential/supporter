count = Needs.find().count()

Meteor.defer ->
  if count is 0
    now = new Date()

    #create Users
    userId = Accounts.createUser(
      username: 'foo'
      name: 'foo'
      password: 'foo'
      email: 'foo@bar.com'
    )

    #create background
    background = Backgrounds.insert(
      name: "Background title"
      description: "Background Summary"
      createdAt: now
      userId: userId
      username: 'foo'
    )

    #create Needs
    need = Needs.insert(
      content: 'Help'
      createdAt: now
      userId: userId
      username: 'foo'
      offerCount: 0
      score: 0
      backgroundId: background
    )

    offer = Offers.insert(
      content: 'reply'
      createdAt: now
      userId: userId
      username: 'foo'
      email: 'foo@bar.com'
      needId: need
      needOwnerId: userId
    )
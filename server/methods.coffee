Meteor.startup ->
  Meteor.methods

    changeEmail: (userId, email) ->
      Meteor.users.update(userId, {
        $set: {
          'emails': [address: email]
        }
      })

    changeUsername: (userId, username) ->
      Meteor.users.update(userId, {
        $set: {
          'username': username
        }
      })

    notifyOffer: (offerId, isEdit) ->
      offer = Offers.findOne(offerId)
      owner = Meteor.users.findOne(offer.needOwnerId)
      email = owner.emails[0].address
      url = Meteor.absoluteUrl "need/#{offer.needId}"
      text = "Hello,\n\n" +
        offer.email + ' has ' + if isEdit then 'edited their response to your need.\n\n' else 'responded to your need.\n\n' +
        '---------------\n' +
        offer.content + "\n" +
        '---------------\n\n' +
        "To view the need, click the link below.\n\n" +
        url + "\n\n" +
        "Thanks!\n\n" +
        "#{Meteor.settings.public.siteName}\n\n"

      Email.send
        to: email
        from: "Supporter.io <no-reply@supporter.io>"
        text: text
        subject: 'Response to your need'

    addSubscription: (userId, query) ->
      Meteor.users.update _id : userId, {
        $push: {
          "profile.subscriptions": query
        }
      }

    watchCard: (cardId) ->
      Meteor.users.update _id : @userId, {
        $push: {
          "profile.watching": cardId
        }
      }

    sendSubscriptions: () ->
      _.each Meteor.users.find().fetch(), (user) ->
        console.log [ "Sending subscription", user._id ]
        tags = user.profile.subscriptions
        if tags && tags.length > 0
          Supporter.sendSubscription(user._id, Supporter.needsToSend(user, tags))

    addAdmin: (emailAddress) ->
      user = Meteor.users.findOne('emails.address': emailAddress)
      if user is undefined
        newUser = Accounts.createUser {
          email: emailAddress
        }
        Accounts.sendEnrollmentEmail newUser
        Roles.addUsersToRoles(newUser, 'admin')
      else
        Roles.addUsersToRoles(user._id, 'admin')

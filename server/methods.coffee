Meteor.startup ->
  Meteor.methods
    changeEmail: (userId, email) ->
      Meteor.users.update(userId, {
        $set: {
          'emails': [address: email]
        }
      })

    notifyOffer: (offerId) ->
      offer = Offers.findOne(offerId)
      owner = Meteor.users.findOne(offer.needOwnerId)
      email = owner.emails[0].address
      url = 'http://supporter.io/need/' + offer.needId
      text = "Hello,\n\n" +
        offer.email + ' has responded to your need.\n\n' +
        '---------------\n' +
        offer.content + "\n" +
        '---------------\n\n' +
        "To view the need, click the link below.\n\n" +
        url + "\n\n" +
        "Thanks!\n\n" +
        "Supporter.io\n\n"

      Email.send
        to: email
        from: "Supporter.io <no-reply@supporter.io>"
        text: text
        subject: 'Response to your need'

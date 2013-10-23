Meteor.startup ->
  Meteor.methods
    notifyOffer: (offerId, isEdit) ->
      offer = Offers.findOne(offerId)
      owner = Meteor.users.findOne(offer.needOwnerId)
      email = owner.emails[0].address
      url = 'http://supporter.io/need/' + offer.needId
      text = "Hello,\n\n" +
        offer.email + ' has ' + if isEdit then 'edited their response to your need.\n\n' else 'responded to your need.\n\n' +
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

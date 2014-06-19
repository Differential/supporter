@Supporter =
  computeScore: (need)->
    f = 1.3 # score decay rate
    age = need.createdAt
    stars = need.starCount
    baseScore = stars* 100 || 1
    ageInHours = (new Date().getTime() - age) / (60 * 60 * 1000)
    score = baseScore / Math.pow(ageInHours + 2, f) * 100
    console.log [stars, baseScore, ageInHours, score]
    score

  sendCard: (userId, cardMap) ->
    user = Meteor.users.findOne(userId)
    content = ""
    for k,v of cardMap
      need = Needs.findOne({_id: k})
      content += "This card ->"
      content += "\n****\n"
      content += need.content
      content += "\n" + Meteor.absoluteUrl "need/#{need._id}"
      content += "\n****\n"
      content += "has some new offers on it!\n"
      console.log v.fetch()
      _.each v.fetch(), (offer) ->
        content += "\nOffer (added on " + offer.createdAt + ")"
        content += "\n"
        content += offer.content
    if cardMap and cardMap.size > 0
      Email.send
        to: user.emails[0].address
        from: "#{Meteor.settings.public.siteName} <no-reply@supporter.io>"
        text: content
        subject: 'Update on Cards you are watching'
      Meteor.users.update {_id : userId}, {$set: { "profile.subscriptionEmailSentAt": new Date() } }
    else
      console.log 'Nevermind, there are no cards to send out'

  sendSubscription: (userId, needs) ->
    if needs and needs.count() > 0
      user = Meteor.users.findOne(userId)
      content = "Recent needs:\n\n"
      _.each needs.fetch(), (need) ->
        console.log need
        content += need.content + "\n"
        content += Meteor.absoluteUrl "need/#{need._id}"
        content += "\n\n"
      Email.send
        to: user.emails[0].address
        from: "#{Meteor.settings.public.siteName} <no-reply@supporter.io>"
        text: content
        subject: 'Recently added needs'
      Meteor.users.update {_id : userId}, {$set: { "profile.subscriptionEmailSentAt": new Date() } }
    else
      console.log 'Nevermind, there are no subscriptions to send out'

  cardOffersToSend: (user, watchList, doItNow) ->
    map = { }
    cards = null
    if watchList and watchList.length > 0
      cards = Needs.find ( { _id: { $in: watchList }} )
    #get offers for each card
    if cards
      _.each cards.fetch(), (card) ->
        if user.profile.subscriptionEmailSentAt
          offers = Offers.find({needId: card._id, createdAt:  { $gt: user.profile.subscriptionEmailSentAt   }})
          if offers and offers.count() > 0
            map[card._id] = offers
        else
          offers = Offers.find({needId: card._id})
          if offers and offers.count() > 0
            map[card._id] = offers
    map

  needsToSend: (user, tagList, doItNow) ->
    if tagList and tagList.length > 0
      if user.profile.subscriptionEmailSentAt
        Needs.find ( { tags: { $in: tagList }, createdAt:  { $gt: user.profile.subscriptionEmailSentAt   } })
      else
        Needs.find ( { tags: { $in: tagList }} )


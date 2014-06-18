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
      content += "has some new offers on it!"
      _.each v.fetch(), (offer) ->
        content += "\nOffer (added on " + offer.createdAt + ")"
        content += "\n"
        content += offer.content
    Email.send
      to: user.emails[0].address
      from: "#{Meteor.settings.public.siteName} <no-reply@supporter.io>"
      text: content
      subject: 'Update on Cards you are watching'
    Meteor.users.update {_id : userId}, {$set: { "profile.subscriptionEmailSentAt": new Date() } }

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

  cardOffersToSend: (user, watchList, doItNow) ->
    map = { }
    cards = null
    if watchList and watchList.length > 0
      cards = Needs.find ( { _id: { $in: watchList }} )
    #get offers for each card
    if cards
      _.each cards.fetch(), (card) ->
        if not doItNow and user.profile.subscriptionEmailSentAt
          map[card._id] = Offers.find({needId: card._id, createdAt:  { $gt: user.profile.subscriptionEmailSentAt   }})
        else
          map[card._id] = Offers.find({needId: card._id})
    map


  needsToSend: (user, tagList, doItNow) ->
    if tagList and tagList.length > 0
      if not doItNow and user.profile.subscriptionEmailSentAt
        Needs.find ( { tags: { $in: tagList }, createdAt:  { $gt: user.profile.subscriptionEmailSentAt   } })
      else
        Needs.find ( { tags: { $in: tagList }} )


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

  sendSubscription: (userId, needs) ->
    if needs.count() > 0
      user = Meteor.users.findOne(userId)
      content = "Recent needs:\n\n"
      _.each needs.fetch(), (need) ->
        console.log need
        content += need.content + "\n"
        content += Meteor.absoluteUrl "need/#{need._id}"
        content += "\n\n"

      if not user.profile.subscriptionEmailSentAt or not new Date().getDate() - user.profile.subscriptionEmailSentAt.getDate() >= 3
        Email.send
          to: user.emails[0].address
          from: "Supporter.io <no-reply@supporter.io>"
          text: content
          subject: 'Recently added needs'

        Meteor.users.update {_id : userId}, {$set: { "profile.subscriptionEmailSentAt": new Date() } }

  needsToSend: (user, tagList) ->
    if user.profile.subscriptionEmailSentAt
      Needs.find ( { tags: { $in: tagList }, createdAt:  { $gt: user.profile.subscriptionEmailSentAt   } })
    else
      Needs.find ( { tags: { $in: tagList }} )

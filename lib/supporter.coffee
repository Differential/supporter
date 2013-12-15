@Supporter =
  computeScore: (need)->
    f = 1.3 # score decay rate
    age = need.createdAt
    stars = need.starCount
    baseScore = stars || 1
    ageInHours = (new Date().getTime() - age) / (60 * 60 * 1000)

    baseScore / Math.pow(ageInHours + 2, f) * 100

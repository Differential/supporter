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

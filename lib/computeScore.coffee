computeScore = (need)->
  n = 30 # days that needs are considered active for scoring purposes
  x = 1/Math.pow(n*24+2,1.3) # what each vote is worth, factoring in the age of the post
  f = 1.3 # score decay rate
  age = need.createdAt
  stars = need.starCount
  baseScore = stars || 1
  ageInHours = (new Date().getTime() - age) / (60 * 60 * 1000)

  baseScore / Math.pow(ageInHours + 2, f)

if module
  module.exports = computeScore

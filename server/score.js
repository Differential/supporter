Meteor.methods({
  updateScore: function (need, forceUpdate) {
  var forceUpdate = typeof forceUpdate != 'undefined' ? forceUpdate : false;

  newScore = Supporter.computeScore(need)

  // days that needs are considered active for scoring purposes
  n = 30

  // what each vote is worth, factoring in the age of the post
  var x = 1/Math.pow(n*24+2,1.3);

  var age = need.createdAt;
  var ageInHours = (new Date().getTime() - age) / (60 * 60 * 1000);

  var scoreDiff = Math.abs(need.score - newScore);

  if (forceUpdate || scoreDiff > x) {
    Needs.update(need._id, {$set: {score: newScore, inactive: false}});
    return 1;
  } else if(ageInHours > n*24) {
    Needs.update(need._id, {$set: {inactive: true}});
  }
  return 0;
}
});

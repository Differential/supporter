Meteor.methods({
  updateScore: function (need, forceUpdate) {
  var forceUpdate = typeof forceUpdate != 'undefined' ? forceUpdate : false;

  newScore = Supporter.computeScore(need)

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

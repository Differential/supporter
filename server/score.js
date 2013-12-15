Meteor.methods({
  updateScore: function (need, forceUpdate) {
  var forceUpdate = typeof forceUpdate != 'undefined' ? forceUpdate : false;

  newScore = Supporter.computeScore(need)

  // Note: before the first time updateScore runs on a new need, its score will be at 0
  var scoreDiff = Math.abs(need.score - newScore);

  // only update database if difference is larger than x to avoid unnecessary updates
  if (forceUpdate || scoreDiff > x) {
    Needs.update(need._id, {$set: {score: newScore, inactive: false}});
    return 1;
  }else if(ageInHours > n*24){
    // only set a post as inactive if it's older than n days
    Needs.update(need._id, {$set: {inactive: true}});
  }
  return 0;
}
});

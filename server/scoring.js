Meteor.startup(function () {
  var scoreInterval = 30;
  if(scoreInterval>0){
    // active items get updated every N seconds
    intervalId=Meteor.setInterval(function () {
      var updatedNeeds = 0;
      // console.log('tick ('+scoreInterval+')');
      Needs.find({'completed': {$ne : true}}).forEach(function (need) {
        updatedNeeds += Meteor.call("updateScore", Needs, need);
      });
    }, scoreInterval * 1000);

    // inactive items get updated every hour
    inactiveIntervalId=Meteor.setInterval(function () {
      var updatedNeeds = 0;
      Needs.find({'completed': true}).forEach(function (need) {
        updatedNeeds += Meteor.call("updateScore",Needs,need)
      });
    }, 3600 * 1000);
  }
});
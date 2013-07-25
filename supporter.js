if (Meteor.isClient) {
  Template.hello.greeting = function () {
    return "Welcome to supporter.";
  };

  Template.hello.events({
    'click input' : function () {
      // template data, if any, is available in 'this'
      if (typeof console !== 'undefined')
        console.log("You pressed the button");
    }
  });
  
   Template.newNeed.events({
  'click input#newNeedButton' : function () {
    // user is creating a resource
    addNeed();
   }
  });
  
  Template.newNeed.events({
  'keypress input#newNeed' : function (evt) {
     // user is creating a resource
     if (evt.which === 13) {
      addNeed();
     }
   }
  });

}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}

function addNeed() {
  var user = Meteor.user();
    if (user && user.username) {
      var newNeed = document.getElementById("newNeed").value;
      Needs.insert({
      content : newNeed, 
      createdAt: new Date(),
      userId : user._Id, 
      username : user.username});
    }
}

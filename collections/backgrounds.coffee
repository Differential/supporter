@Backgrounds = new Meteor.Collection("backgrounds")

@Backgrounds.allow
  insert: (userId, doc) -> userId
  update: (userId, doc) -> userId
  remove: (userId, doc) -> userId

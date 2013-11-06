@Needs = new Meteor.Collection("needs")

@Needs.allow
  insert: (userId, doc) -> userId
  update: (userId, doc) -> userId
  remove: (userId, doc) -> userId

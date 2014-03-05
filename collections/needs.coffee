@Needs = new Meteor.Collection("needs")

@Needs.allow
  insert: (userId, doc) -> true
  update: (userId, doc) -> true
  remove: (userId, doc) -> true

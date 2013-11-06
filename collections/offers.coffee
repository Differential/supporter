@Offers = new Meteor.Collection("offers")

@Offers.allow
  insert: (userId, doc) -> userId
  update: (userId, doc) -> userId
  remove: (userId, doc) -> userId

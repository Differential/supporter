Template.admin.events
  'click #addAdmin': ->
    email = $('#emailaddress').val()
    console.log email
    Meteor.call 'addAdmin', email

Template.admin.helpers
  'admins': ->
    Roles.getUsersInRole 'admin'

  'email': ->
    @emails[0].address

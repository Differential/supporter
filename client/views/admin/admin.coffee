Template.admin.events
  'click #addAdmin': ->
    email = $('#emailaddress').val()
    console.log email
    Meteor.call 'addAdmin', email

Meteor.startup ->

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'

  AccountsEntry.config
    homeRoute: '/'
    dashboardRoute: '/'
    profileRoute: '/profile'
    wrapLinks: true

  Session.set('chars', 0)
  Session.set('editingOffer', null)

  Meteor.subscribe('offers')
  Meteor.subscribe('backgrounds')
  Meteor.subscribe('needs')

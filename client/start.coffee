Meteor.startup ->
  Accounts.ui.config(
    passwordSignupFields: 'USERNAME_AND_EMAIL'
  )

  AccountsEntry.config =
    logo: 'unpolished.png'
    homeRoute: 'needs'
    dashboardRoute: 'needs'
    profileRoute: 'profile'
    wrapLinks: true

  Session.set('chars', 0)
  Session.set('editingOffer', null)

  Meteor.subscribe('offers')

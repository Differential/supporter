Meteor.startup ->
  Accounts.ui.config(
    passwordSignupFields: 'USERNAME_AND_EMAIL'
  )

  AccountsEntry.config =
    homeRoute: 'needs'
    dashboardRoute: 'needs'
    profileRoute: 'profile'
    wrapLinks: true

  Session.set('chars', 0)

  Meteor.subscribe('offers')

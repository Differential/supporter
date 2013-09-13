Meteor.startup ->
  Accounts.ui.config(
    passwordSignupFields: 'USERNAME_AND_EMAIL'
  )

  AccountsEntry.config =
    homeRoute: 'needs'
    dashboardRoute: 'needs'

  Session.set('chars', 0)

  Meteor.subscribe('needs')
  Meteor.subscribe('offers')

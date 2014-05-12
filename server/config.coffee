Accounts.emailTemplates.siteName = Meteor.settings.public.siteName
Accounts.emailTemplates.from = "no-reply@supporter.mailgun.org"

Accounts.onCreateUser (options, user) ->
  if user.services.google
    service = _.keys(user.services)[0]
    email = user.services[service].email
    user.profile = {}
    user.profile.google = true
    user.emails = []
    user.emails[0] = { address: email }

    # see if any existing user has this email address, otherwise create new
    existingUser = Meteor.users.findOne("emails.address": email)
    return user  unless existingUser

    # precaution, these will exist from accounts-password if used
    unless existingUser.services
      existingUser.services = resume:
        loginTokens: []

    # copy accross new service info
    existingUser.services[service] = user.services[service]
    existingUser.services.resume.loginTokens.push user.services.resume.loginTokens[0]
    existingUser.profile.google = true

    # even worse hackery
    Meteor.users.remove _id: existingUser._id # remove existing record
    existingUser # record is re-inserted
  else
    if options.profile
      user.profile = options.profile
    else
      user.profile = {}
    user

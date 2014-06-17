Template.welcomeCard.helpers
  'siteName': ->
    title = "We want to hear from startups!"
    if Meteor.settings.public.siteName isnt "Represent Cincy"
      title = Meteor.settings.public.siteName
    title

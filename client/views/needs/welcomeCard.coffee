Template.welcomeCard.siteName = ->
  Meteor.settings.public.siteName

Template.welcomeCard.helpers
  'represent': ->
    true if Meteor.settings.public.siteName is "Represent Cincy"

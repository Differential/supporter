Router.configure
  layout: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"
  renderTemplates:
    footer:
      to: "footer"
    header:
      to: "header"

Router.map ->
  @route 'needs',
    path: '/'
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().profile)
        return @redirect('profile')
      else
        @render 'needs'
    
  @route 'need',
    path: '/need/:_id'
    data: ->
      Needs.findOne @params._id
    waitOn: ->
      Meteor.subscribe('needs')

  @route 'userProfile',
    path: '/u/:_id'
    data: ->
      Needs.findOne @params._id
      
  @route 'profile',
    path: '/profile'

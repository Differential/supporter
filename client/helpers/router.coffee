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
      if (Meteor.user() && !Meteor.user().profile.name)
        return @redirect('profile')
      else
        @render 'needs'
    data: ->
      Needs.find()

  @route 'myNeeds',
    path: '/mine'
    template: 'needs'
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().profile.name)
        return @redirect('profile')
      else
        @render 'needs'
    data: ->
      Needs.find({userId: Meteor.userId()}, sort: {createdAt: -1})

  @route 'need',
    path: '/need/:_id'
    data: ->
      Needs.findOne @params._id
    waitOn: ->
      Meteor.subscribe('needs')

  @route 'user',
    path: '/u/:username'
    data: ->
      Meteor.users.findOne(username: @params.username)
    waitOn: ->
      Meteor.subscribe('user', @params.username)

  @route 'profile',
    path: '/profile'
    data: ->
      Meteor.user()

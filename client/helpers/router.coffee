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
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().profile.name)
        return @redirect('profile')
      else
        @render 'needs'
    data: ->
      Needs.find({}, {sort: {createdAt: -1}})


  @route 'myNeeds',
    path: '/mine'
    template: 'needs'
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
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
    before: ->
      Session.set('sendingTo', null)
      Session.set('respondingTo', null)
    data: ->
      Needs.findOne @params._id
    waitOn: ->
      Meteor.subscribe('needs')
      Meteor.subscribe('offers')

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

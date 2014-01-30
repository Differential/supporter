Router.configure
  layoutTemplate: "layout"
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
    data: ->
      Needs.find({}, {sort: {score: -1}})
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'myNeeds',
    path: '/mine'
    template: 'needs'
    data: ->
      Needs.find({userId: Meteor.userId()}, sort: {score: -1})
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'need',
    path: '/need/:_id'
    data: ->
      Needs.findOne @params._id
    waitOn: ->
      Meteor.subscribe('needs')
      Meteor.subscribe('offers')
    before: ->
      Session.set('sendingTo', null)
      Session.set('respondingTo', null)

  @route 'user',
    path: '/u/:username'
    data: ->
      user: Meteor.users.findOne(username: @params.username)
      needs: Needs.find(username: @params.username)
    waitOn: ->
      Meteor.subscribe('user', @params.username)
      Meteor.subscribe('userNeeds', @params.username)

  @route 'profile',
    path: '/profile'
    data: ->
      Meteor.user()

  @route 'strNeeds',
    path: '/fav'
    template: 'needs'
    data: ->
      Needs.find ({starUsers: { $in: [Meteor.user()._id] }}  )
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('strNeeds')
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'topNeeds',
    path: '/top'
    template: 'needs'
    data: ->
       Needs.find({}, {sort: {score: -1}})
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    before: ->
      if (Meteor.loggingIn())
        @render 'loading'
        return @stop()
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

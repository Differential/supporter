Router.configure
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"
  yieldTemplates:
    footer:
      to: "footer"

Router.onBeforeAction 'loading'

Router.map ->
  @route 'needs',
    path: '/'
    data: ->
      needs: Needs.find({}, {sort: {score: -1}})
      backgrounds: Backgrounds.find()
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    onBeforeAction: ->
      if (Meteor.loggingIn())
        @render 'loading'
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'myNeeds',
    path: '/mine'
    template: 'needs'
    data: ->
      needs: Needs.find({userId: Meteor.userId()}, sort: {score: -1})
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    onBeforeAction: ->
      if (Meteor.loggingIn())
        @render 'loading'
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'need',
    path: '/need/:id'
    data: ->
      Needs.findOne @params.id
    waitOn: ->
      Meteor.subscribe('need', @params.id)
      Meteor.subscribe('offersForNeed', @params.id)
    onBeforeAction: ->
      Session.set('sendingTo', null)
      Session.set('respondingTo', null)

  @route 'backgrounds',
    path: '/backgrounds'
    data: ->
      backgrounds: Backgrounds.find({}, {sort: {score: -1}})
      needs: Needs.find({})
    waitOn: ->
      Meteor.subscribe 'backgrounds', Session.get('query')
    onBeforeAction: ->
      if (Meteor.loggingIn())
        @render 'loading'
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'backgrounds'

  @route 'background',
    path: '/background/:id'
    data: ->
      Backgrounds.findOne @params.id
    waitOn: ->
      Meteor.subscribe('needs')
      Meteor.subscribe('offers')
      Meteor.subscribe('backgrounds')
    onBeforeAction: ->
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
      needs: Needs.find ({starUsers: { $in: [Meteor.user()._id] }}  )
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('strNeeds')
    onBeforeAction: ->
      if (Meteor.loggingIn())
        @render 'loading'
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

  @route 'topNeeds',
    path: '/top'
    template: 'needs'
    data: ->
       needs: Needs.find({}, {sort: {score: -1}})
    waitOn: ->
      Meteor.subscribe 'needs', Session.get('query')
    onBeforeAction: ->
      if (Meteor.loggingIn())
        @render 'loading'
      if (Meteor.user() && !Meteor.user().username)
        return @redirect('profile')
      else
        @render 'needs'

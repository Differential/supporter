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

  @route 'need',
    path: '/need/:_id'
    data: ->
      Needs.findOne @params._id
    waitOn: ->
      Meteor.subscribe('needs')

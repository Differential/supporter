Router.map -> 
  @route 'needs',
    path: '/'
  @route 'need',
    path: '/need/:_id'
    data: ->
      Needs.findOne @params._id
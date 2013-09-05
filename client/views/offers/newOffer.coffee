addOffer = ->
  user = Meteor.user()
  if user and user.username
    newOffer = $('#newOffer').val()
    if newOffer.length > 30
      $('#newOffer').val ''
      Offers.insert
        content: newOffer
        createdAt: new Date()
        userId: user._Id
        username: user.username
        email: user.emails[0].address
        needId: Session.get('editing_itemname')
      Needs.update(Session.get('editing_itemname'), {$inc: {offerCount: 1}})
    else
      alert 'Be more descriptive'



Template.newOffer.events
  "click .newOfferButton": ->
    addOffer()
    Session.set('editing_itemname',null)

  "keypress input#newOffer": (evt) ->
    addOffer() if evt.which is 13

  "click .cancel": ->
    Session.set('editing_itemname', null)

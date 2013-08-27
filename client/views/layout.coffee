Template.layout.events
  "click input#showMyNeeds": ->
    Session.set('myNeeds', true)
  "click input#showAllNeeds": ->
    Session.set('myNeeds', false)
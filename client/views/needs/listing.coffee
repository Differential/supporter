

Template.needListing.helpers
  owner: ->
    Meteor.user() != null && Meteor.user().username == @username

Template.needListing.helpers
  editing: ->
    Session.equals('editing_itemname', @_id)

Template.needListing.events
  'click .delete': ->
    Needs.remove(@_id)
     
      
Template.needListing.events
  "click .btn": ->
    Session.set('editing_itemname', @_id)
      
Template.needListing.rendered = ->
  container = $('ul.needs-list')
  items = container.find('li')

  if (not container.hasClass("isotope")) and (items.length-1 == Needs.find().count())
    container.isotope
      itemSelector: "li"
      layoutMode: "masonry"
      getSortData:
        number: ($elem) ->
          parseInt $elem.text(), 10

    container.isotope sortBy: "number"
  else if container.hasClass("isotope")
    container.isotope "addItems", $(@find("li:not(.isotope-item)")), ->
      container.isotope sortBy: "number"

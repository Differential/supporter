Template.needListing.helpers
  owner: ->
    Meteor.user().username == @username

Template.needListing.events
  'click .delete': ->
    Needs.remove(@_id)

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

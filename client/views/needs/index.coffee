Template.needs.helpers
	needs: ->
    Needs.find()

Template.needs.preserve('li')

Meteor.startup ->
  $(window).resize (evt) ->
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

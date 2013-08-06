Template.needs.helpers
	needs: ->
    Needs.find()

Template.needs.preserve('.need')

Meteor.startup ->
  $(window).resize (evt) ->
    container = $('.needs-list')
    items = container.find('.need')

    if (not container.hasClass("isotope")) and (items.length-1 == Needs.find().count())
      container.isotope
        itemSelector: ".need"
        layoutMode: "masonry"
        getSortData:
          number: ($elem) ->
            parseInt $elem.text(), 10

      container.isotope sortBy: "number"
    else if container.hasClass("isotope")
      container.isotope "addItems", $(@find(".neet:not(.isotope-item)")), ->
        container.isotope sortBy: "number"

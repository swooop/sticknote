// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

  /////////////////////////////////////////////////////////
  // Get JSON from Meetup API through own front-end hack //
  /////////////////////////////////////////////////////////

  $.getJSON('/events/meetup_api.json', function(data) {

    $('#event-list').html("");

    $.each(data, function(key, value) {
      var venueName = "Only ninjas can find this place!";

      if (value.venue) {
          venueName = value.venue.name;
      }

      ////////////////////////////////////////
      // Create Meetup event list from JSON //
      ////////////////////////////////////////

      $('#event-list').append("<li class='meet' data-event-id='" + value.id + "' data-event-name='" + value.name + "' data-event-link='" + value.event_url + "' data-event-group='" + value.group.name + "' data-event-venue='" + venueName + "' data-event-time='" + value.time + "'>" + 
                                "<p class='event-url event-name'><a target='_blank' href='" + value.event_url + "'>" + value.name + "</a></p>" +
                                "<p class='event-group'>" + value.group.name + "</p>" +
                                "<p class='event-venue'>" + venueName + "</p>" +
                                "<p class='event-time'>" + value.time + "</p>" +
                              "</li>");

      // Add data to li... ideally.
      // $('.meet').data('edata', {id: value.id,
      //                           name: value.name,
      //                           link: value.event_url,
      //                           venue: venueName,
      //                           time: value.time
      // });

    });

    /////////////////////////////////////
    // Change UNIX time with moment.js //
    /////////////////////////////////////

    var eventTimes = $('.event-time');
    for (var i = 0; i < eventTimes.length; ++i) {
      var eventTime = parseInt($(eventTimes[i]).text());
      $(eventTimes[i]).html(moment(eventTime).format('DD/MM/YYYY, H:mm'));
    }

    $(".sortable").sortable({

      connectWith: '.sortable',
      
      receive: function(event, ui) {
        var element = $(ui.item[0]);

        if (element.parent('ul').attr('id') === 'event-list') {
          console.log('dropped into event list');
        } else if (element.parent('ul').attr('id') === 'user-list') {
          console.log('dropped into user list');
          console.log($(element[0]).data('event-id'));

          var meetupId = $(element[0]).data('event-id');
          var meetupEventName = $(element[0]).data('event-name');
          var meetupGroupName = $(element[0]).data('event-group');
          var meetupEventVenue = $(element[0]).data('event-venue');
          var meetupTime = $(element[0]).data('event-time');
          var meetupLink = $(element[0]).data('event-link');

          $.ajax( { url: "/events/nomz",
            data: JSON.stringify({id : meetupId,
                                  name : meetupEventName,
                                  group : meetupGroupName,
                                  venue : meetupEventVenue,
                                  time : meetupTime,
                                  link : meetupLink
              }),
            type: "PUT",
            contentType: "application/json" } );
        }
      }
    }).disableSelection();

  });
});

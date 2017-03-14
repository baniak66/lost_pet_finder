// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function() {
  handler = Gmaps.build('Google');
  if ($('#map').length) {
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      markers = handler.addMarkers([
        {
          "lat": gon.announcement.latitude,
          "lng": gon.announcement.longitude,
          "infowindow": gon.announcement.title
        }
      ]);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(15);
    });
  } else if ($('#map_all').length) {
    handler.buildMap({ provider: {}, internal: {id: 'map_all'}}, function(){
      markers = handler.addMarkers(gon.announcements);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    });
  }
});


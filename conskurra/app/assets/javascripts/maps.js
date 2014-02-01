function initialize() {
   var myLatlng= new google.maps.LatLng(32.765, -56.8976)
    mapOptions = {
    zoom: 4,
    center: myLatlng
  };
   map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}
function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' +
      'callback=initialize';
  document.body.appendChild(script);
}
function  loadLocations() {
    $("#my-div").children('.map').each(function  () {
      var loc = JSON.parse($(this).attr("data-marker"));
      console.log(loc);
      var myLatlng= new google.maps.LatLng(loc.l, loc.n);
      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map
      });
    });
  }  
window.onload = loadScript;

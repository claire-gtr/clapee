function initNearMe() {
  const nearMeButton = document.getElementById("near-me");

  nearMeButton.addEventListener('click', function(e) {
    e.preventDefault();
    navigator.geolocation.getCurrentPosition(function(position) {
      window.location.href = "/?lat=" + position.coords.latitude + "&lng=" + position.coords.longitude;
    });
  });

}

export { initNearMe };

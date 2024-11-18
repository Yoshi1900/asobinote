document.addEventListener('turbolinks:load', () => {
// function jpostal() {
  $('#playground_post_code').jpostal({
    postcode : ['#playground_post_code'],
    address : {
      '#playground_address': '%3%4%5'
    }
  });
});
// $(document).on("turbolinks:load", jpostal);
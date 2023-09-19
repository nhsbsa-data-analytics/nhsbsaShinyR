$(document).ready(function () {
  // Whenever navigation tab button is clicked, window scrolls to the top
  $('#mainTabs a[data-toggle=\"tab\"]').on('click', function (e) {
    window.scrollTo(0, 0);
  });
  
  // Remove aria attributes from anchor tags to prevent accessibility issues
  var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      if (mutation.type === "attributes") {
        mutation.target.removeAttribute("aria-selected");
      }
    })
  });
  
  // Not really necessary with just one flag, but may want to add further 
  // observer behaviour later
  var config = {attributes: true};

  // Add observers for all navigation links
  document.querySelectorAll('#mainTabs a[data-toggle=\"tab\"]').
    forEach(function(element){
      observer.observe(element, config);
    });
});

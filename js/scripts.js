var PAGES = ['archives', 'styleguide', 'authors'];

// Add/display the mobile menu button, and
$.ready().then(function() {
  $("body").classList.add("js");
  var menu = $("#js-menu");
  var menuLink = $(".topbar-menu-btn");
  var menuClose = $(".topbar-btn-close");
  var topbar = $(".topbar");
  // Toggle the display of menu links
  menuLink
  .addEventListener("click", function(event) {
    menuLink.classList.toggle("active");
    menu.classList.toggle('active');
    menuClose.classList.toggle('active');
    topbar.classList.toggle('active');
    return false;
  });
  menuClose
  .addEventListener("click", function(event) {
    menuLink.classList.toggle("active");
    menu.classList.toggle('active');
    menuClose.classList.toggle('active');
    topbar.classList.toggle('active');
    return false;
  });
 displayCurrentMenuItem(window.location.pathname);
});

/**
 * Add a visible marker on the menu item in the topbar, to know in
 * which category we are.
 * @params {string} [pathname] - An URL path.
 * @returns {void}
 */
function displayCurrentMenuItem(pathname){
  path = pathname.split('/');
  if (findInArray(PAGES, path[1])) {
    $(".page-"+path[1]).classList.add("topbar-navigation-item-current");
  }
  else {
    $(".page-home").classList.add("topbar-navigation-item-current");
  }
}

/**
 * Returns true or false based on whether an object is found in an array.
 * @params {array} [arr] - An array where the search is happening.
 * @params {object} [obj] - An element yoy want to search.
 * @returns {boolean} true if found else false
 */
function findInArray(arr, obj) {
  return (arr.indexOf(obj) != -1);
}

var PAGES = ['archives', 'styleguide', 'authors'];

// Add/display the mobile menu button, and
$.ready().then(function() {
    $('body').classList.add('js');
    var menuButton = $('.topbar-menu-btn');
    var menuCloseButton = $('.topbar-btn-close');
    menuButton.addEventListener('click', menuEventHandler);
    menuCloseButton.addEventListener('click', menuEventHandler);
    displayCurrentMenuItem(window.location.pathname);
});


/**
 * Mobile Menu Event Handler
 * Toggles the appropriate CSS classes when menu buttons are clicked.
 *
 * @returns {void}
 */
function menuEventHandler() {
    $('.topbar-menu-btn').classList.toggle('active');
    $('#js-menu').classList.toggle('active');
    $('.topbar-btn-close').classList.toggle('active');
    $('.topbar').classList.toggle('active');
}

/**
 * Add a visible marker on the menu item in the topbar, to know in
 * which category we are.
 * @params {string} [pathname] - An URL path.
 * @returns {void}
 */
function displayCurrentMenuItem(pathname){
    var path = pathname.split('/');
    if (findInArray(PAGES, path[1])) {
        $('.page-'+path[1]).classList.add('topbar-navigation-item-current');
    }
    else {
        $('.page-home').classList.add('topbar-navigation-item-current');
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

var PAGES = ['archives', 'styleguide', 'authors'];

// Add/display the mobile menu button, and
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('body').classList.add('js');
    addMenuClickEvent('.topbar-menu-btn');
    addMenuClickEvent('.topbar-btn-close');
    displayCurrentMenuItem(window.location.pathname);
});

/**
 * Add Click event on the Menu based on a selector.
 * @params {string} [selector] A DOMString containing one selector to match.
 *                             This string must be a valid CSS selector string.
 * @returns {void}
 */
function addMenuClickEvent(selector) {
    var element = document.querySelector(selector);
    element.addEventListener('click', menuEventHandler);
}

/**
 * Mobile Menu Event Handler
 * Toggles the appropriate CSS classes when menu buttons are clicked.
 * @returns {void}
 */
function menuEventHandler() {
    document.querySelector('#js-menu').classList.toggle('active');
    document.querySelector('.topbar').classList.toggle('active');
    document.querySelector('.topbar-menu-btn').classList.toggle('active');
    document.querySelector('.topbar-btn-close').classList.toggle('active');
}

/**
 * Add a visible marker on the menu item in the topbar, to know in
 * which category we are.
 * @params {string} [pathname] - An URL path.
 * @returns {void}
 */
function displayCurrentMenuItem(pathname){
    var path = pathname.split('/');
    var pageElement = null;
    if (findInArray(PAGES, path[1])) {
        pageElement = document.querySelector('.page-'+path[1]);
    }
    else {
        pageElement = document.querySelector('.page-home');
    }
    pageElement.classList.add('topbar-navigation-item-current');
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

'use strict';
var SetEmail, clicked, datajs, isMobile, navList, navToggle, navigation,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

datajs = function(selector) {
  return document.querySelectorAll("[data-js=" + selector + "]");
};

Element.prototype.addClass = function(className) {
  if (!this.hasClass(className)) {
    return this.className += ' ' + className;
  }
};

Element.prototype.hasClass = function(className) {
  return new RegExp(' ' + className + ' ').test(' ' + this.className + ' ');
};

Element.prototype.removeClass = function(className) {
  var newClass;
  newClass = " " + this.className.replace(/[\t\r\n]/g, " ") + " ";
  if (this.hasClass(className)) {
    while (newClass.indexOf(" " + className + " ") >= 0) {
      newClass = newClass.replace(" " + className + " ", " ");
    }
    return this.className = newClass.replace(/^\s+|\s+$/g, " ");
  }
};

isMobile = function() {
  return !!(__indexOf.call(window, 'ontouchstart') >= 0) || !!(__indexOf.call(navigator, 'msmaxtouchpoints') >= 0);
};

navigation = document.querySelector('[data-js=nav-toggle]');

navList = document.querySelector('[data-js=nav]');

clicked = false;

navToggle = function(event) {
  var self;
  self = this;
  if (!clicked) {
    self.addClass('is--open');
    navList.addClass('is--open');
  } else {
    self.removeClass('is--open');
    navList.removeClass('is--open');
  }
  clicked = !clicked;
  return event.preventDefault();
};

if (isMobile()) {
  navigation.addEventListener('touchstart', navToggle, false);
} else {
  navigation.addEventListener('click', navToggle);
}


/*
  Prevent Spam by Generating the Email
 */

SetEmail = function() {
  var element, email, link, name;
  element = document.querySelector('.header__nav__list__item--contact');
  name = "devin";
  email = "mailto:" + name + "@" + name + "schulz" + ".com";
  link = element.firstElementChild;
  return link.setAttribute("href", email);
};

SetEmail();

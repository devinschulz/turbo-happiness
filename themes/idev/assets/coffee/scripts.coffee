'use strict'

datajs = (selector) ->
  document.querySelectorAll "[data-js=" + selector + "]"

Element::addClass = (className) ->
  unless @hasClass className
    @className += ' ' + className

Element::hasClass = (className) ->
  new RegExp(' ' + className + ' ').test ' ' + @className + ' '

Element::removeClass = (className) ->
  newClass = " " + @className.replace(/[\t\r\n]/g, " ") + " "
  if @hasClass(className)
    while newClass.indexOf(" " + className + " ") >= 0
      newClass = newClass.replace(" " + className + " ", " ")
    @className = newClass.replace(/^\s+|\s+$/g, " ")

# Check if mobile
isMobile = ->
  return !!('ontouchstart' in window) or !!('msmaxtouchpoints' in navigator)

navigation = document.querySelector '[data-js=nav-toggle]'
navList = document.querySelector '[data-js=nav]'
clicked = false

navToggle = (event) ->
  self = @
  unless clicked
    self.addClass 'is--open'
    navList.addClass 'is--open'
  else
    self.removeClass 'is--open'
    navList.removeClass 'is--open'
  clicked = not clicked
  event.preventDefault()

if isMobile()
  navigation.addEventListener('touchstart', navToggle, false)
else
  navigation.addEventListener('click', navToggle)

###
  Prevent Spam by Generating the Email
###
SetEmail = ->
  element = document.querySelector('.header__nav__list__item--contact')
  name = "devin"
  email = "mailto:" + name + "@" + name + "schulz" + ".com"
  link = element.firstElementChild
  link.setAttribute("href", email)
SetEmail()
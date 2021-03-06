$(document).ready ->
  menu = document.getElementById('menu')
  WINDOW_CHANGE_EVENT = if 'onorientationchange' of window then 'orientationchange' else 'resize'

  toggleHorizontal = ->
    [].forEach.call document.getElementById('menu').querySelectorAll('.custom-can-transform'), (el) ->
      el.classList.toggle 'pure-menu-horizontal'

  toggleMenu = ->
    # set timeout so that the panel has a chance to roll up
    # before the menu switches states
    if menu.classList.contains('open')
      setTimeout toggleHorizontal, 500
    else
      toggleHorizontal()
    menu.classList.toggle 'open'
    document.getElementById('toggle').classList.toggle 'x'

  closeMenu = ->
    if menu.classList.contains('open')
      toggleMenu()


  document.getElementById('toggle').addEventListener 'click', (e) ->
    e.preventDefault()
    toggleMenu()

  window.addEventListener WINDOW_CHANGE_EVENT, closeMenu


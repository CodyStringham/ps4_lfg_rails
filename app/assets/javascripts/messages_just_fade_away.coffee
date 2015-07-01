# flash notice timeout and clear
$(document).ready ->
  if $('.notices').is(':visible')
    setTimeout (->
      $('.notices').fadeOut 500
    ), 4000

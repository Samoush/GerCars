# $(document).ready ->
# $("backup-link").click ->

$(document).on "page:fetch", ->
  $(".spinner").show();

$(document).on "page:receive", ->
  $(".spinner").hide();  




###
$(document).ready ->
  $("#backup-link").click ->
    $(".spinner")
###

###
->          eine funktion
(...)       returned ein JQuery Objekt
###
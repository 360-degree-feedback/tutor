# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "click", ".slide", ->
  id = $(this).attr('content')
  $('.box').attr('class','box hidden')
  $('.box[content="'+id+'"]').attr('class','box')
  $('.page').attr('class', 'page')
  $(this).parent().attr('class', 'page active')






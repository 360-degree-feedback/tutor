# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "click", ".slide", ->
  id = $(this).attr('content')
  $('.box').attr('class','box hidden')
  $('.box[content="'+id+'"]').attr('class','box')
  $('.page').attr('class', 'page')
  $(this).parent().attr('class', 'page active')

jQuery ->
  $('#lessons').DataTable(
    "bInfo": false
    "order": []
    "lengthChange": false
    "oLanguage" : {
      "sSearch": "<span class='glyphicon glyphicon-search'></span> Search ",
      "sEmptyTable": "No Lessons have been added."
    }
    "columnDefs": [
      {'sortable': false, 'targets':[3,4,5]},
      {'searchable': false, 'targets':[3,4,5]}
    ]
  )




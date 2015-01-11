# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#tests').DataTable(
    "bInfo": false
    "order": []
    "lengthChange": false
    "oLanguage" : {"sSearch": "<span class='glyphicon glyphicon-search'></span> Search "}
    "columnDefs": [
      {'sortable': false, 'targets':[7]},
      {'searchable': false, 'targets':[7]}
    ]
  )
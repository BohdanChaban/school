$(document).ready ->
  $(".journal-table").clone(true).appendTo('#table-scroll').addClass('clone');
  $(".clone").removeClass('table-bordered')

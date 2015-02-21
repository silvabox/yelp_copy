# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.endorsements-link').on 'click' (event) ->
    event.preventDefault()
  
    endorsementCount = $(this).siblings '.endorsements_count'
  
    $.post this.href, ->
      endorsementCount.text response.new_endorsement_count

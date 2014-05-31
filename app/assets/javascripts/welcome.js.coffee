# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', ':checkbox', ->
    user_id = $(this).attr('id');
    cohort_id = $(this).attr('data-cohort-id');
    $.ajax '/users/add_user_to_cohort',
      type: 'PATCH',
      data: { "users": { "cohort_id": cohort_id, "user_id": user_id }}
      
      success: (data, textStatus, jqXHR) -> 
        if data == '0'
          alert("You cannot remove ironyarders from a cohort this way. Click the 'remove' button to start this process")
          document.getElementById(user_id).checked = true;
        else
          console.log('success');
  
  $(document).on 'click', '.remove', ->
    user_id = $(this).attr('data-user-id');
    user_email = $(this).attr('data-user-email');
    cohort_id = $(this).attr('data-cohort-id');
    confirm_string = "Are you sure you want to remove " + user_email + " from this cohort?"
    if confirm(confirm_string)
      $.ajax '/users/remove_user_from_cohort',
      type: 'PATCH',
      data: { "users": { "cohort_id": cohort_id, "user_id": user_id }}
      success: -> 
        console.log('success')

      error: ->
        alert("There was a problem removing this user. Please try again.")



    
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(document).on 'click', '.add_to_cohort_button', (e) ->
      user_id = $(this).attr('data-user-id');
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

  $(document).on 'click', '.admin_checkbox', ->
    user_id = $(this).attr('data-user-id');
    $.ajax '/users/make_admin',
      type: 'PATCH',
      data: { "users": { "user_id": user_id }}
      
      success: (data, textStatus, jqXHR) -> 
        if data == '0'
          alert("Something went wrong. We were unable to promote the user to admin.")
        else
          console.log('success');
  
  $(document).on 'click', '.remove', ->
    user_id = $(this).attr('data-user-id');
    user_email = $(this).attr('data-user-email');
    console.log(user_email)
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

  $(document).on 'click', '.more_description', ->
    $('.truncated_description').slideToggle('fast');
    $('.hidden_description').slideToggle('fast');

  $(document).on 'click', '.more_submission', ->
    $('.truncated_content').slideToggle('fast');
    $('.hidden_content').slideToggle('fast');

  $(document).on 'click', '#fade', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.close', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.course_modal_button', ->
    $('.new_course_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.location_modal_button', ->
    $('.new_location_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.create_cohort_button', ->
    $('.new_cohort_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_cohort_button', ->
    $('.edit_cohort_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_cohort_button', ->
    $('.new_cohort_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.add_user_button', ->
    $('.add_user_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.create_assignment_button', ->
    $('.new_assignment_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_assignment_button', ->
    $('.edit_assignment_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.submit_submission_button', ->
    $('.submit_submission_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_submission_button', ->
    $('.edit_submission_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.reject_submission', ->
    $('.reject_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.accept_submission', ->
    $('.accept_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_submission_button', ->
    $('.edit_submission_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.resubmit_button', ->
    $('.resubmit_submission_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.edit_assignment_button', ->
    $('.edit_assignment_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.create_admin_button', ->
    $('.create_admin_modal').fadeIn();
    $('#fade').fadeIn();

 



  




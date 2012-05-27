$(document).ready ->
  $("#registerHere input").hover ->
    $(this).popover "show"

  $("#registerHere").validate
    rules:
      user_name: "required"
      user_email:
        required: true
        email: true

      pwd:
        required: true
        minlength: 6

      cpwd:
        required: true
        equalTo: "#pwd"

      gender: "required"

    messages:
      user_name: "Enter your first and last name"
      user_email:
        required: "Enter your email address"
        email: "Enter valid email address"

      pwd:
        required: "Enter your password"
        minlength: "Password must be minimum 6 characters"

      cpwd:
        required: "Enter confirm password"
        equalTo: "Password and Confirm Password must match"

      gender: "Select Gender"

    errorClass: "help-inline"
    errorElement: "span"
    highlight: (element, errorClass, validClass) ->
      $(element).parents(".control-group").addClass "error"

    unhighlight: (element, errorClass, validClass) ->
      $(element).parents(".control-group").removeClass "error"
      $(element).parents(".control-group").addClass "success"

  $("#login").validate
    rules:
      user_name: "required"
      password: "required"

    messages:
      user_name: "Enter your username"
      password: "Enter your Password"

    errorClass: "help-inline"
    errorElement: "span"
    highlight: (element, errorClass, validClass) ->
      $(element).parents(".control-group").addClass "error"

    unhighlight: (element, errorClass, validClass) ->
      $(element).parents(".control-group").removeClass "error"
      $(element).parents(".control-group").addClass "success"
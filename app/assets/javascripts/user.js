$(document).ready(function(){

  $.validator.addMethod('email_tip', function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/.test(value);
  }, "Please enter valid email.");

  $.validator.addMethod('password_tip', function(value, element) {
    return this.optional(element) || /^(?!\s)([a-zA-Z0-9@_#$!$]){8,16}$/.test(value);
  }, "Please enter valid password.");

  $("#login-user").validate({
        // Specify the validation rules
      rules: {
        "user[email]": {
          required: true,
          email: true,
          email_tip: true,
          maxlength: 64
          },
        "user[password]": {
          required: true,
          password_tip: true,
          minlength: 8,
          maxlength: 16
        }

      },
        // Specify the validation error messages
      messages: {
          "user[email]": {
            required: "Please enter email.",
            email: "Please enter valid email."
          },
          "user[password]": {
            required: "Please enter password."
          }

        },

      submitHandler: function(form) {
        form.submit();
      }
  });


  $("#new_user").validate({
        // Specify the validation rules
      rules: {
        "user[email]": {
          required: true,
          email: true,
          email_tip: true,
          maxlength: 64
        }

      },
        // Specify the validation error messages
      messages: {
        "user[email]": {
          required: "Please enter email.",
          email: "Please enter valid email."
        }

      },

      submitHandler: function(form) {
        form.submit();
      }
  });




  $("#edit_user").validate({
        // Specify the validation rules
      rules: {
        "user[password]": {
          required: true,
          password_tip: true,
          minlength: 8,
          maxlength: 16
        },
        "user[password_confirmation]": {
            required: true,
            password_tip: true,
            minlength: 8,
            maxlength: 16,
            equalTo: "#user_password"
          } ,
        "user[current_password]":{
          required: true,
          password_tip: true,
          minlength: 8,
          maxlength: 16
        }

      },
        // Specify the validation error messages
      messages: {
        "user[password]": {
          required: "Please enter password."
            // password: "Please enter valid password."
        },
        "user[password_confirmation]": {
          required: "Please enter  password confirmation.",
          equalTo: "Password confirmation didn't matched."
        },
        "user[current_password]": {
          required: "Please enter  current password .",

        }

      },

      submitHandler: function(form) {
        form.submit();
      }
  });


  $("#forget-password").validate({
        // Specify the validation rules
      rules: {
        "user[email]": {
          required: true,
          email: true,
          email_tip: true,
          maxlength: 64
        }
      },
        // Specify the validation error messages
      messages: {
          "user[email]": {
            required: "Please enter email.",
            email: "Please enter valid email."
          }

      },

      submitHandler: function(form) {
        form.submit();
      }
  });


  $("#reset-password").validate({
        // Specify the validation rules
      rules: {
        "user[reset_password_token]": {
          required: true,
          password_tip: true,
          minlength: 8,
          maxlength: 16
        },
        "user[password_confirmation]": {
          required: true,
          password_tip: true,
          minlength: 8,
          maxlength: 16
        }

      },

        // Specify the validation error messages
      messages: {
        "user[reset_password_token]": {
          required: "Please enter password."

        },
        "user[password_confirmation]": {
          required: "Please enter password."

        }

      },
      submitHandler: function(form) {
        form.submit();
      }
  });


});


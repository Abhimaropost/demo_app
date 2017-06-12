 $(document).ready(function(){


  $.validator.addMethod('email_tip', function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/.test(value);
  }, "Please enter valid email.");

  jQuery.validator.addMethod("lettersonly", function(value, element) {
    return this.optional(element) || /^[a-z]+$/i.test(value);
  }, "Letters only please");

  $("#contact_us").validate({

        // Specify the validation rules
        rules: {

          "c_name": {
            required: true,
            lettersonly: true,
            minlength: 3,
            maxlength: 20
          },
          "c_email": {
            required: true,
            email: true,
            email_tip: true,
            maxlength: 64
          },
          "c_phone": {
            required: true,
            digits: true,
            minlength: 10,
            maxlength: 12
          },
          "c_description": {
            required: true,
            maxlength: 500
          }

        },

        // Specify the validation error messages
        messages: {

          "c_name": {
            required: "Please enter your name."
          },
          "c_email": {
            required: "Please enter email.",
            email: "Please enter valid email."
          },
          "c_phone": {
            required: "Please enter phone number."
          },
          "c_description": {
            required: "Please enter message."
          }

        },

        submitHandler: function(form) {
          form.submit();
        }
      });

      });

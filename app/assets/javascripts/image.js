$(document).ready(function(){
console.log("hai!")
 $("#image-form").validate({
        // Specify the validation rules
        rules: {
          "image[title]": {
            required: true,
            maxlength: 20,
            remote: "images/validate_uniqueness"
          }
        },

        // Specify the validation error messages
        messages: {
           "image[title]": {
            required: "Please enter title.",
          }
        },
        submitHandler: function(form) {
          form.submit();
        }
      });






//  var formData = new FormData(),
//     $input = $('#avatar');

// formData.append('user[avatar]', $input[0].files[0]);

// $.ajax({
//   url: this.model.url(),
//   data: formData,
//   cache: false,
//   contentType: false,
//   processData: false,
//   type: 'PUT'
// });






});




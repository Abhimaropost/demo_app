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





$(".image-title").keypress(function(event){
    var cntMaxLength = $(this).attr('maxlength');
    $this= this
    $pre_title= $(this).data('title')
    $title = $(this).text().replace(/\-/g, '');
    if ( parseInt($title.length) === parseInt(cntMaxLength) && event.keyCode != 8 ) {
         event.preventDefault();
    }

    if(event.keyCode == 13 && $pre_title==$title && ( $($this).hasClass('title-editable') )  ){
      $($this).attr('contenteditable', 'false');
      $($this).removeClass('title-editable');
    }


    if(event.keyCode == 13 && $pre_title!=$title){
      id = $(this).attr('id');
      $.ajax({
        type: "POST",
        url: 'images/update_title',
        data:{id: id, title: $title},
        dataType: "json",
        success:function(data){
          if (data === true){
           $($this).attr('contenteditable', 'false');
           $($this).removeClass('title-editable');
           $($this).text($title);
           $($this).data('title',$title);


          }
          else{
            alert("Title should be unique!");
            $($this).attr('contenteditable', 'false');
            $($this).removeClass('title-editable');
            $($this).text($pre_title);

          }
        }
      });
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




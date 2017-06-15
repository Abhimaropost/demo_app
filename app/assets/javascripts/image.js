$(document).ready(function(){
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
            remote:"Title already exist."

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
      id= id.split("_")[1]
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




});




$(document).ready(function(){

$(".image-submit").on('click',function(e){
// $("#title-val").on('focusout',function(e){
  console.log("focusout")
    e.preventDefault();
    $title = $('#title-val').val().trim();
    $(".error").hide();
    $(".error").html('');
    var count = 0;
    if ($title === '') {
      count+=1  ;
      $(".error_title").html('Title is required.');
    } else {
      $.ajax({
            type: "GET",
            url: "/images/validate_uniqueness",
            data:{title: $title},
            dataType: "json",
            success:function(data){
              if (data == true){

                 count=+1;

                 $('.error_title').html('Title should be unique!');
              }
        },

      });

    };
    setTimeout(function(){
 if(parseInt(count) >= 1) {
      $(".error").show();
    }
    else{
      $(".image-submit").unbind('click').click();
    // $(".image-submit").unbind('click').click();
    }
  },100);

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




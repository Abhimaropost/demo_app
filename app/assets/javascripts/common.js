 $(document).ready(function(){

// image validation
  $(document).on('change', '.upload', function() {
    var ext;
    ext = $(this).val().split('.').pop().toLowerCase();
    var preview = true;

    console.log(this.files[0].size / 1024);
    jpg_check = ext.indexOf("jpg")
    jpeg_check = ext.indexOf("jpeg")
    png_check = ext.indexOf("png")

    if (jpg_check === 0 || jpeg_check === 0 || png_check === 0 ){
      console.log("111111")
    }else{
      console.log("22222222")

      alert("Invalid format! Only jpeg, jpg and png are allowed.");
      $(this).val('');
    }

    if ((this.files[0].size / 1024) > (1024 * 3)) {
      console.log("333333file size checking")
      alert('Invalid size, Please choose image below 3 Mb!');
      $(this).val('');
    }

    if (preview === true) {
      target_element = $(this).data('preview-element-id')
      ReadURL(this,target_element);
   }

  });


  ReadURL = function(current_element, target_element ) {
    if (current_element.files && current_element.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {

           $('#'+target_element).attr('src', e.target.result);

        }
      }
      reader.readAsDataURL(current_element.files[0]);
      $('.image-text-val').removeClass("hide");
      $('.image-submit').removeClass("hide");
      // $('.image-title').style.display = 'none' ;



    }





});
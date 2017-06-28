module CommonMethod
  extend self
  # for match string of an array
  def regex_matcher hash
  	  # byebug
  	  match_string = hash[:match_string]
  	  if hash[:header_array]
  	    result = (hash[:header_array].find{|object| /#{match_string}/ =~ object }).nil?
  	  elsif hash[:match_title]
        result =  !hash[:match_title].match(/http/).nil?
      elsif hash[:match_image]
        result =  (hash[:match_image].match(/http/).nil?)
  	  end
  	  result
  end
  # csv validator method
  def csv_head_validator hash
  	resulted_array = hash[:header] - hash[:file_header]
  	status, message = false, ""
	if  ( resulted_array === [] and hash[:file_header].reverse === hash[:header] )
		message = HEADER_SWAPPED
	elsif resulted_array === []
		  message = UPLOAD_SUCCESS
		  status = true
	elsif resulted_array === ["title"]
		message = HEADER_TITLE_MISSING
	elsif resulted_array === ["photo"]
		message = HEADER_PHOTO_MISSING
	elsif  ( ( resulted_array === hash[:header] ) and ( CommonMethod.regex_matcher({header_array: hash[:file_header] , match_string: "http" })))
		message = HEADER_WRONG
	elsif  !(CommonMethod.regex_matcher({header_array: hash[:file_header] , match_string: "http" }))
		message = HEADER_BLANK
	end
    return status, message
   end

  def csv_row_validator row_data
  	# byebug
  	status,message = true ,UPLOAD_SUCCESS

  	if ( ( CommonMethod.regex_matcher({match_title: row_data[:row_title] }) ) || ( CommonMethod.regex_matcher({ match_image: row_data[:row_image] })))
  	  status = false
  	  if $redis.get("error_count").blank?
     	 $redis.set("error_count", 0)
  	  end
      error_count = $redis.get("error_count").to_i + 1
      $redis.set("error_count", error_count)
    else
	  	status = true
  	end
    return status ,message
  end


end

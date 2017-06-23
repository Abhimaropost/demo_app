require 'csv'
require 'common_method'
class Image < ActiveRecord::Base
  belongs_to :user#, :touch => true
  mount_uploader :photo, AvatarUploader
  scope :all_except, ->(object) { where.not(id: object) }
  validates :title, presence: true,uniqueness: true
  validates :photo, presence: true

  def self.import(file,user)
    $redis.del("success_count","error_count") # deleting last file upload success and error count
    object_arr ,  header_arr , count ,status , message = [] , ["title","photo"] , 0 , false , "";
    CSV.foreach(file.path, {:encoding => 'utf-8', headers: true, skip_blanks: true}) do |row|
      if count === 0
        status , message= CommonMethod.csv_head_validator( {header: header_arr , file_header: row.headers} )
        return message if status === false
      end
      status , message= CommonMethod.csv_row_validator({row_title: row["title"], row_image: row['photo']})
      if status === true
        listing_hash = {:title => row['title'],:remote_photo_url => (row['photo']).gsub('http://','https://'),user_id: user.id, type: "image" }
        object_arr.push(listing_hash)
      end
      count+=1;
    end # end CSV.foreach
    BackgroundWorker.perform_async(object_arr) unless object_arr.blank?
    return (message.blank?  ? DATA_BLANK : message)
  end # end self.import(file)

  def self.create_object object_arr
    success_count , error_count = $redis.get("success_count").to_i, $redis.get("error_count").to_i
    object_arr.map{|object|
      image = Image.new(object.except("type"))
      if image.save
        success_count+=1;
      else
        error_count+=1;
      end
    }
    $redis.mset("success_count", success_count , "error_count", error_count)
    $redis.expire("success_count",1200)
    $redis.expire("error_count",1200)
  end # end self.create_object

  # image encoding
  def self.image_data(data)
    return nil unless data
    io = CarrierStringIO.new(Base64.decode64(data))
    return io
  end

end

class CarrierStringIO < StringIO
  def original_filename
    "photo.jpeg"
  end

  def content_type
    "image/jpeg"
  end
end

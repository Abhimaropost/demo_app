require 'csv'
class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, AvatarUploader
  scope :all_except, ->(object) { where.not(id: object) }
  validates :title, presence: true,uniqueness: true
  validates :photo, presence: true

  def self.import(file,user)
      object_arr = [];
	    CSV.foreach(file.path, {:encoding => 'utf-8', headers: true}) do |row|
	  	# byebug
     	    listing_hash = {:title => row['title'],:remote_photo_url => (row['photo']).gsub('http://','https://'),user_id: user.id }
          object_arr.push(listing_hash)
      end # end CSV.foreach
      BackgroundWorker.perform_async(object_arr)
  end # end self.import(file)


  def self.create_object object_arr
    # byebug
      $redis.del("success_count","error_count")
      success_count = error_count = 0;
      object_arr.map{|object|
        image = Image.new(object)
        if image.save
          success_count+=1;
        else
          error_count+=1;
        end
      }
      $redis.mset("success_count", success_count , "error_count", error_count)
      # $redis.set("error_count", error_count)
  end # end self.create_object


end


#redis demonize
# image csv in batches
# notification bar automatic refresh in each 5 seconds
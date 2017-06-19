require 'csv'
class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, AvatarUploader
  scope :all_except, ->(object) { where.not(id: object) }
  validates :title, presence: true,uniqueness: true
  validates :photo, presence: true

  def self.import(file,user)
  	   error_count = 0;
  	   success_count = 0;
	  CSV.foreach(file.path, {:encoding => 'utf-8', headers: true}) do |row|
	  	# byebug
     	 listing_hash = {:title => row['title'],:remote_photo_url => (row['photo']).gsub('http://','https://') }
     	 image = user.images.new(listing_hash)
     	 if image.save
			success_count+=1;
     	 else
            error_count+=1;
     	 end
      end # end CSV.foreach
      return success_count, error_count
  end # end self.import(file)


end

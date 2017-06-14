# require 'carrierwave/orm/activerecord'
class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, AvatarUploader

  scope :all_except, ->(object) { where.not(id: object) }

  validates :title, presence: true,uniqueness: true
  validates :photo, presence: true


end

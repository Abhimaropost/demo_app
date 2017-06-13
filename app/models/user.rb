class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images, :dependent => :destroy
  after_commit :acknowledge_mail  , :on => :create ## send acknowlegement mail to user

  def acknowledge_mail
      Notify.welcome_email(self).deliver
  end
end

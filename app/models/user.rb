class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images, :dependent => :destroy
  # before_validation :generate_password, :on => :create
  after_commit :acknowledge_mail  , :on => :create ## send acknowlegement mail to user
  attr_accessor :random_password

  def self.assign_password
    password = User.generate_password
    @random_password = password
    password
  end

  def self.generate_password
      first_segment = ('a'..'z').to_a
      midle_segment= (0..9).to_a
      last_segment= ('A'..'Z').to_a
      password = (0...2).map {
        first_segment.sample }.join + (0...7).map {
        midle_segment.sample }.join + (0...1).map {
        last_segment.sample }.join rescue SecureRandom.hex(5)
  end

  def acknowledge_mail
    mail_hash={object: self, password: @random_password}
    Notify.welcome_email(mail_hash).deliver_now
  end

end






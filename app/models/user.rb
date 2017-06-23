class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images, :dependent => :destroy
  before_create { generate_token(:auth_token) }
  after_commit :acknowledge_mail  , :on => :create ## send acknowlegement mail to user

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.assign_password email
    password = User.generate_password
    $redis.set(email, password)
    $redis.expire(email, 60)
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
    password = $redis.get(self.email)
    mail_hash={email: self.email, password: password,type: "acknowledge"}
    BackgroundWorker.perform_async mail_hash
  end

end


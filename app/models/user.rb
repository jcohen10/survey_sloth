class User < ActiveRecord::Base
  attr_reader :entered_password

  has_many :answers
  has_many :possible_choices, through: :answers
  has_many :completed_surveys
  has_many :surveys, foreign_key: :creator_id

  # validates :username, :length => { :minimum => 3, :message => "must be at least 3 characters" }
  # validates :email, :uniqueness => true, :format => /.+@.+\..+/
  validates :entered_password, :length => { :minimum => 6 }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil
  end

end

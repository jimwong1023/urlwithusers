

class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :format => { :with => /.{2,}\@.+\.(com|net|edu)/ }
  validates :email, :presence => true, :uniqueness => true

  has_many :urls, dependent: :destroy

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    (user && user.password == params[:password]) ? user : nil
  end

  def self.create(user)
    @user = User.new(
                     :first_name => user[:first_name], 
                     :last_name => user[:last_name],
                     :email => user[:email]  
                     )
    @user.password = user[:password]
    @user.save ? @user : nil
  end

  # def self.authenticate(user_hash)
  #   if (user = User.find_by_email(user_hash[:email]))
  #     user.password == user_hash[:password] ? user : nil
  #   end
  # end
end

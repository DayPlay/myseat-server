class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def convert_birthday (birthday)
  	self.birthday = Time.at(birthday / 1000).to_date
  end

  def save_auth_token
  	self.auth_token = SecureRandom.uuid
  end

  def save_password
  	pasword = Base64.decode64(self.encrypted_password)
  					.force_encoding('UTF-8')
  					.encode
  					.gsub("myseat", "")

  	self.encrypted_password = BCrypt::Password.create(pasword)
  end
end

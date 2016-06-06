class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def convert_birthday (birthday)
  	self.birthday = Time.at(birthday / 1000).to_date
  end

  def save_auth_token
  	self.auth_token = SecureRandom.uuid
  end

  def self.parse_password (base64_password)
  	return Base64.decode64(base64_password)
  					.force_encoding('UTF-8')
  					.encode
  					.gsub("myseat", "")
  end

  def save_password
  	password = User.parse_password(self.encrypted_password)
  	puts password
  	self.encrypted_password = BCrypt::Password.create(password.to_s, cost: 10)
  end

  def get_password
  	return BCrypt::Password.new(self.encrypted_password)
  end
end

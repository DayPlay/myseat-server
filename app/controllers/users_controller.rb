class UsersController < ApplicationController

  def index
  	@user = User.find(params[:id]) unless params[:id].blank?
  end

  def sign_up
    @user = User.new(user_sign_up_params)
    @user.save_password
    @user.convert_birthday(params[:user][:birthday])
    @user.save_auth_token
    @user.save
  end

  def sign_in
  end

  def sign_out
  end

	private
  	def user_sign_up_params
    	params.require(:user).permit(:email, :encrypted_password, :nickname, :gender, :phone, :birthday, :has_noti, :is_partner, :is_admin)
  	end

		def user_sign_in_params
			params.require(:user).permit(:email, :password)
		end

		def user_sign_in_auth_params
			params.require(:user).permit(:user_id, :auth_token)
		end
end

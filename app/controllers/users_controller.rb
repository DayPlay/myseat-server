class UsersController < ApplicationController

  def index
  	@user = User.find(params[:id]) unless params[:id].blank?
  end

  def sign_up
  	@user = User.new(user_sign_up_params)
    @user.birthday = Time.at(params[:user][:birthday]).strftime('%m-%d-%Y') unless params[:user][:birthday].empty?
  	@user.save

    # @user.auth_token = params[:user][:auth_token]
  	# puts request.body
  end

  def sign_in
  end

  def sign_out
  end

	private
  	def user_sign_up_params
    	params.require(:user).permit(:email, :nickname, :gender, :phone)
  	end

		def user_sign_in_params
			params.require(:user).permit(:email, :password)
		end

		def user_sign_in_auth_params
			params.require(:user).permit(:user_id, :auth_token)
		end
end

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
    email = params.require(:user).fetch(:email, nil)
    password = params.require(:user).fetch(:password, nil)
    user_id = params.require(:user).fetch(:user_id, nil)
    auth_token = params.require(:user).fetch(:auth_token, nil)

    checked = false
    if !user_id.nil? && !auth_token.nil?
      @user = User.find_by id: user_id 
      checked = @user.auth_token == auth_token unless @user.nil?
    elsif !email.nil? && !password.nil?
      @user = User.find_by email: email
      checked = @user.get_password == User.parse_password(password) unless @user.nil?
    else
      return render json: { msg: "give me user info" }, status: :bad_request
    end

    return render json: { msg: "not fount user" }, status: :not_found if @user.nil? || checked == false
  end

  def sign_out
    user_id = params.require(:user).fetch(:user_id, nil)
    auth_token = params.require(:user).fetch(:auth_token, nil)

    return render json: { msg: "give me user info" }, status: :bad_request if user_id.nil? || auth_token.nil?

    @user = User.find_by id: user_id
    checked = false
    checked = @user.auth_token == auth_token unless @user.nil?
    return render json: { msg: "not fount user" }, status: :not_found if @user.nil? || checked == false

    @user.deleted_at = DateTime.now
    @user.save
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

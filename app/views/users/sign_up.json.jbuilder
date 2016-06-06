json.user do
	json.id @user.id
	json.email @user.email
	json.nickname @user.nickname
	json.auth_token @user.auth_token
end
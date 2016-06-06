json.user do
	json.id @user.id
	json.deleted_at @user.deleted_at.to_i
end
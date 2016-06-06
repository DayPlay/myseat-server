class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string   :email,              null: false, default: ""
      t.boolean  :verfied_email,      null: false, default: false

      t.string   :encrypted_password, null: false, default: ""

      t.string   :auth_token,         null: false

      t.string   :nickname
      t.string   :picture_url
      t.string   :gender

      t.integer  :point,              null: false, default: 0
      t.string   :phone

      t.datetime :birthday

      t.boolean  :has_noti,           null: false, default: true

      t.boolean  :is_partner,         null: false, default: false
      t.boolean  :is_admin,           null: false, default: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :nickname,             unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end

class CreateUserPartTimeJobTimes < ActiveRecord::Migration
  def change
    create_table :user_part_time_jobs do |t|
      t.integer :user_id
      t.integer :start_time
      t.integer :end_time

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    add_column :users, :work_place_id, :integer, :after => :is_admin

  end
end

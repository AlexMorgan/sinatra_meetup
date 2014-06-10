class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups do |t|
      t.integer :user_id, null: false
      t.integer :meetup_id, null: false
    end
    add_index :user_meetups,
      [:user_id, :meetup_id],
      unique: true
  end
end

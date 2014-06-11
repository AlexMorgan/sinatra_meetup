class AddMeetupIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :meetup_id, :integer, null: false
  end
end

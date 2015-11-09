class AddUserToTabs < ActiveRecord::Migration
  def change
    add_reference :tabs, :user, index: true, foreign_key: true
  end
end

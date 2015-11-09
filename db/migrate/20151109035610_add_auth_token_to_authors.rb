class AddAuthTokenToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :auth_token, :string
  end
end

class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :comments, :article_name, :author_name
  end
end

class RenameArticleToBlog < ActiveRecord::Migration
  def change
    rename_table :articles, :blogs
  end
end

class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :title
      t.string :content
      t.references :blog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

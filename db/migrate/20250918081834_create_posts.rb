class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :thumbnail_url
      t.string :video_url
      t.boolean :pro

      t.timestamps
    end
  end
end

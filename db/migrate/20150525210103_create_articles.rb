class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, id: false do |t|
      t.primary_key :twitter_id
      t.string :site
      t.text :url
      t.string :title
      t.text :photo_url
      t.text :description
      t.date :published_at
      t.boolean :is_active

      t.timestamps
    end
  end
end

class CreateGalleriesGalleryEntries < ActiveRecord::Migration

  def self.up
    create_table :galleries do |t|
      t.string :name
      t.text   :body
      t.integer :position

      t.timestamps
    end

    add_index :galleries, :id

    create_table :gallery_entries do |t|
      t.string  :name
      t.text    :body
      t.integer :image_id
      t.integer :position
      t.integer :gallery_id
      t.integer :entry_type, :default => 0
      t.timestamps
    end

    add_index :gallery_entries, :id

    load(Rails.root.join('db', 'seeds', 'galleries.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "galleries"})

    Page.delete_all({:link_url => "/galleries"})

    drop_table :galleries
    drop_table :gallery_entries
  end

end

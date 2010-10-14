class GalleryEntry < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :body]

  validates_presence_of :name, :image
  validates_uniqueness_of :name, :scope => [:gallery_id]
  validates_inclusion_of :entry_type, :in => 0..1

  belongs_to :gallery
  belongs_to :image

  def self.types
    {
      :image => 0,
      :video => 1
    }
  end

  def image?
    entry_type == self.class.types[:image]
  end

  def video?
    entry_type == self.class.types[:video]
  end

  self.types.each do |type_name, value|
    eval("scope :#{type_name}, where(:entry_type => #{value})")
  end

end

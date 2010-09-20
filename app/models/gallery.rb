class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :body]

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :gallery_entries

end

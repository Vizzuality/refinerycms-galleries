class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :body]

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :gallery_entries, :dependent => :destroy

  # when a dialog pops up with galleries, how many galleries per page should there be
  PAGES_PER_DIALOG = 18

  # when a dialog pops up with galleries, but that dialog has image resize options
  # how many galleries per page should there be
  PAGES_PER_DIALOG_THAT_HAS_SIZE_OPTIONS = 12

  # when listing galleries out in the admin area, how many galleries should show per page
  PAGES_PER_ADMIN_INDEX = 20

  class << self
    # How many galleries per page should be displayed?
    def per_page(dialog = false, has_size_options = false)
      if dialog
        unless has_size_options
          PAGES_PER_DIALOG
        else
          PAGES_PER_DIALOG_THAT_HAS_SIZE_OPTIONS
        end
      else
        PAGES_PER_ADMIN_INDEX
      end
    end
  end


end

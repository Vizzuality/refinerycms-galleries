class Admin::GalleriesController < Admin::BaseController

  crudify :gallery, :title_attribute => :name

end

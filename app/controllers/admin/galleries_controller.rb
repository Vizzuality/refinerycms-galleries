class Admin::GalleriesController < Admin::BaseController

  crudify :gallery, :title_attribute => :name

  # This renders the image insert dialog
  def insert
    self.new if @gallery.nil?

    @callback = params[:callback]

    @url_override = admin_galleries_url(:dialog => from_dialog?, :insert => true)

    if params[:conditions].present?
      extra_condition = params[:conditions].split(',')

      extra_condition[1] = true if extra_condition[1] == "true"
      extra_condition[1] = false if extra_condition[1] == "false"
      extra_condition[1] = nil if extra_condition[1] == "nil"
      paginate_galleries({extra_condition[0].to_sym => extra_condition[1]})
    else
      paginate_galleries
    end

    render :action => "insert"
  end

  protected

  def paginate_galleries(conditions={})
    @galleries = Gallery.paginate :page => (@paginate_page_number ||= params[:page]),
                                  :conditions => conditions,
                                  :order => 'created_at DESC',
                                  :per_page => Gallery.per_page(from_dialog?, !@app_dialog)
  end


end

class Admin::GalleryEntriesController < Admin::BaseController

  before_filter :set_gallery

  def new
    @gallery_entry = @gallery.gallery_entries.new
  end

  def create
    # if the position field exists, set this object as last object, given the conditions of this class.
    if GalleryEntry.column_names.include?("position")
      params[:gallery_entry].merge!({
        :position => ((@gallery.gallery_entries.maximum(:position, :conditions => "")||-1) + 1)
      })
    end

    @gallery_entry = @gallery.gallery_entries.new(params[:gallery_entry])

    if @gallery_entry.valid?
      @gallery_entry.save
      unless request.xhr?
        flash[:notice] = t('refinery.crudify.created',
                           :what => @gallery_entry.name)
      else
        flash.now[:notice] = t('refinery.crudify.created',
                               :what => @gallery_entry.name)
      end
      unless from_dialog?
        unless params[:continue_editing] =~ /true|on|1/
          redirect_to edit_admin_gallery_url(@gallery)
        else
          unless request.xhr?
            redirect_to :back
          else
            render :partial => "/shared/message"
          end
        end
      else
        render :text => "<script type='text/javascript'>parent.window.location = '#{edit_admin_gallery_url(@gallery)}';</script>"
      end
    else
      unless request.xhr?
        render :action => 'new'
      else
        render :partial => "/shared/admin/error_messages",
               :locals => {
                 :object => @gallery_entry,
                 :include_object_name => true
               }
      end
    end
  end

  def edit
  end

  def update
    if @gallery_entry.update_attributes(params[:gallery_entry])
      unless request.xhr?
        flash[:notice] = t('refinery.crudify.updated',
                           :what => @gallery_entry.name)
      else
        flash.now[:notice] = t('refinery.crudify.updated',
                               :what => @gallery_entry.name)
      end
      unless from_dialog?
        unless params[:continue_editing] =~ /true|on|1/
          redirect_to edit_admin_gallery_url(@gallery)
        else
          unless request.xhr?
            redirect_to edit_admin_gallery_url(@gallery)
          else
            render :partial => "/shared/message"
          end
        end
      else
        render :text => "<script type='text/javascript'>parent.window.location = '#{edit_admin_gallery_url(@gallery)}';</script>"
      end
    else
      unless request.xhr?
        render :action => 'edit'
      else
        render :partial => "/shared/admin/error_messages",
               :locals => {
                 :object => @gallery_entry,
                 :include_object_name => true
               }
      end
    end
  end

  def destroy
    if @gallery_entry.destroy
      flash[:notice] = t('refinery.crudify.destroyed',
                         :what => @gallery_entry.name)
    end
    redirect_to edit_admin_gallery_url(@gallery)
  end

  protected

    def set_gallery
      @gallery = Gallery.find_by_id(params[:gallery_id])
      if params[:id]
        @gallery_entry = @gallery.gallery_entries.find(params[:id])
      end
    end

end

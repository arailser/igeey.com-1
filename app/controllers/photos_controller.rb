class PhotosController < ApplicationController
  before_filter :login_required,   :except => [:show]
  before_filter :find_photo,       :except => [:create,:new]
  before_filter :check_permission, :only => [:destroy,:update]
  
  def new
    @venue = Venue.find(params[:venue_id])
    @photo = @venue.photos.build()
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.user = current_user
    @photo.save
    redirect_to :back
  end

  def update
    @photo.update_attributes(params[:photo]) if @photo.owned_by?(current_user)
    if params[:back_path].present?
      redirect_to params[:back_path]
    else
      respond_with @photo
    end
  end

  def destroy
    @photo.destroy
    redirect_to :back
  end
  
  def edit
  end
  
  def show
    @comments = @photo.comments
    render :layout => false if params[:layout] == 'false'
  end
  
  private
  
  def find_photo
    @photo = Photo.find(params[:id])
  end
  
  def check_permission
    redirct_to :back unless @photo.owned_by?(current_user) 
  end
end

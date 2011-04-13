class VenuesController < ApplicationController
  respond_to :html,:json
  before_filter :login_required, :except => [:index, :show,:records,:followers,:more_timeline,:position,:watching]
  before_filter :find_venue, :except => [:index,:new,:create]
  
  def index
    @venues_hash = {}
    @categories = Venue::CATEGORIES_HASH.to_a[0..5]
    @categories.each do |k,v|
      @venues_hash[v.to_sym] = Venue.where(:category => k).limit(6)
    end
  end
  
  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(params[:venue])
    @venue.creator = current_user
    @venue.init_geocodding
    flash[:notice] = 'Venue was successfully created.' if @venue.save
    respond_with(@venue)
  end
  
  def show
    @callings = @venue.callings.limit(11)
    @photos = @venue.photos.limit(11)
    @sayings = @venue.sayings.limit(11)
    @topics = @venue.topics.limit(11)
    @timeline = @venue.events.limit(11)
    @followers = @venue.followers.limit(8)
  end
  
  def more_timeline
    if ['photos','sayings','topics','callings'].include?(params[:filter])
      @timeline = eval "@venue.#{params[:filter]}.paginate(:page => params[:page], :per_page => 10)"
      @filter = params[:filter]
    else
      @timeline = @venue.events.paginate(:page => params[:page], :per_page => 10)
    end
    render :layout => false
  end
  
  def edit
  end
  
  def update
    @venue.update_attributes(params[:venue]) if @venue.creator == current_user
    if params[:back_path].present?
      redirect_to params[:back_path]
    else
      respond_with(@venue)
    end
  end

  def cover
    render :layout => false if params[:layout] == 'false'
  end
  
  def position
    render :layout => false if params[:layout] == 'false'
  end
  
  def records
    @records = @venue.records
    respond_with(@records)
  end
  
  def callings
    @callings = @venue.callings
    respond_with(@callings)
  end
  
  def topics
    @topics = @venue.topics
    respond_with(@topics)
  end
  
  def sayings
    @sayings = @venue.sayings
    respond_with(@sayings)
  end
  
  def photos
    @photos = @venue.photos
    respond_with(@photos)
  end
  
  def followers
    @followers = @venue.followers.paginate(:page => params[:page], :per_page => 20)
  end
  
  def watching
    @venue.update_attribute(:watch_count,(@venue.watch_count + 1))
    render :text => 'OK'
  end
  
  private
  def find_venue
    @venue = Venue.find(params[:id])
  end
end

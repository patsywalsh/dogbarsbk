class PlacesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    # if !session[:access_token]
    #   redirect_to Instagram.authorize_url(:redirect => 'http://localhost:3000')
    # elsif response.access_token.present?
      

      @places = Place.all
      puts @places
      @hash = Gmaps4rails.build_markers(@places) do |place, marker|
        marker.lat place.latitude
        marker.lng place.longitude
        marker.infowindow render_to_string(:partial => "places/infowindow", :locals => { :place => place})

      end
  end

  # def instagram_callback
  #   return if session[:access_token]
  #   response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  #   session[:access_token] = response.access_token
  #   redirect_to places_path
  # end
  
  # GET /places/1
  # GET /places/1.json
  def show
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(:partial => "places/infowindow", :locals => { :place => place})

    end
    client = Instagram.client(:access_token => session[:access_token])
    @results = client.media_search(@place.latitude, @place.longitude, :distance => 11)
   
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place } #, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place } #, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url } #, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :description, :neighborhood, :rating, :address, :latitude, :longitude, :location)
    end
end

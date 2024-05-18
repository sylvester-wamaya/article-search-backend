class SearchesController < ApplicationController
 
  # GET /searches
  def index
    @searches = Search.all

    render json: @searches
  end
  # GET /search statistics
  def search_stats
    @ip_searches = Search.group(:ip)

    render json: @ip_searches
  end


  # POST /searches
  def create
    @ip_address = request.remote_ip
    @search = params[:query]

    Search.create(search: @search, ip: @ip_address)
    
    if @search.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end


  private
  
    # Only allow a list of trusted parameters through.
    def search_params
      params.require(:search).permit(:search, :ip)
    end
end

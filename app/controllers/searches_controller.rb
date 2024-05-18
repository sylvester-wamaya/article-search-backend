class SearchesController < ApplicationController
 
  # GET /searches
  def index
    @searches = Search.all

    render json: @searches
  end
  # GET /search statistics
 
  def search_stats
    @final_searches = Search.group(:ip).maximum(:created_at)

    @ip_searches = @final_searches.map do |ip, t|
      Search.find_by(ip: ip, created_at: t).search
    end
    render json: @ip_searches
  end

  # POST /searches
  def create
    @ip_address = request.remote_ip
    @search = params[:searchValue]
    Search.create!(search: @search, ip: @ip_address)
    
    head :ok
  end
end

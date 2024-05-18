class SearchesController < ApplicationController
 
  # GET /searches
  def index
    @searches = Search.all

    render json: @searches
  end
  # GET /search statistics
 
  def search_stats
    @search_count = Search.distinct.pluck(:search, :ip, :created_at).map { |search| {search: search, count: Search.where(search: search).count} }
       
    @search_summary = @search_count.sort_by { |search| search[:count] }.reverse
    render json: @search_summary
  
  end

  # POST /searches
  def create
    @ip_address = request.remote_ip
    @search = params[:searchValue]
    Search.create!(search: @search, ip: @ip_address)
    
    head :ok
  end
end

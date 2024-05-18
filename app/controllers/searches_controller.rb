class SearchesController < ApplicationController
 
    # GET /searches
    def index
      @searches = Search.all
      render json: @searches
    end

    # GET /search statistics
    def search_stats
      @user = User.find_by(ip_address: request.remote_ip) 
      @search_count = @user.searches.distinct.pluck(:search, :ip).map { |search| {search: search, count: Search.where(search: search).count} }
      
      # Sort the search summary by count in descending order
      @search_summary = @search_count.sort_by { |search| search[:count] }.reverse
      render json: @search_summary 
    
    end

    # POST /searches
      def create
      @ip_address = request.remote_ip
      @user = User.find_by(ip_address: @ip_address) || User.create!(username: @ip_address , ip_address: @ip_address, password: "password")
      @search = params[:searchValue]

      # Check if the search value already exists in the database
      @existing_search = @user.searches.where("search LIKE ?", "%#{@search}%").first

      if @existing_search.present? && Search.find_by(search: @search)
        Search.create!(search: @search, ip: @ip_address, user_id: @user.id)
      end
      if @existing_search.nil?
        # Create a new Search record only if it doesn't exist
        Search.create!(search: @search, ip: @ip_address, user_id: @user.id)
      end  

      head :ok
    end
  end
  



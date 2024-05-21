class SearchesController < ApplicationController
 


    # GET /search statistics
    def index
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

      
      @existing_searches = @user.searches || []

      if check_incomplete_searches(@existing_searches, @search).empty?
        Search.create!(search: @search, ip: @ip_address, user_id: @user.id)
      end
    

      head :ok
    end

    private

    def check_incomplete_searches(arr, search)
      @filtered_arr = []

    
      arr.each do |obj|
       
        if obj[:search].start_with?(search) && obj[:search].length > search.length
          @filtered_arr << obj
        end
        if search.start_with?(obj[:search]) && search.length > obj[:search].length
          obj.destroy
      end
    end
    
      @filtered_arr
    end

  end
    
  
  



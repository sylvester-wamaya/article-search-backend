class ApplicationController < ActionController::API
   

    before_action :set_cors_headers
  
    private
  
    def set_cors_headers
      headers['Access-Control-Allow-Origin'] = '*'  # Replace with your desired origin(s)
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'  # Adjust as needed
      headers['Access-Control-Allow-Headers'] = '*'  # Customize allowed headers
      headers['Access-Control-Max-Age'] = '1728000'  # Optional: Set preflight cache duration
    end
end

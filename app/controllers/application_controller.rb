class ApplicationController < ActionController::Base
	before_action :allow_cross_domain_access

	def allow_cross_domain_access
    	response.headers["Access-Control-Allow-Origin"] = '*'
    	response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
    	response.headers['Access-Control-Request-Method'] = '*'
    	response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

  	end
end

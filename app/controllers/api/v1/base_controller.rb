class Api::V1::BaseController < ActionController::API
	# respond_to :json
	include Response
	include CustomException
	include ExceptionHandler
	include ActiveUser
	#include Pagination

end
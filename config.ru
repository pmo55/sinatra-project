require_relative './config/environment'


use Rack::MethodOverride
use ReviewsController
use UserController
run ApplicationController

require "sinatra"
require "sinatra/reloader" if development?
require_relative "controllers/book_controller.rb"

use Rack::Reloader
use Rack::MethodOverride

run BookController

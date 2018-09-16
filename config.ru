require "sinatra"
require "sinatra/cookies"
require "sinatra/reloader" if development?
require "pg"
require_relative "controllers/book_controller.rb"
require_relative "models/book.rb"

use Rack::Reloader
use Rack::MethodOverride

run BookController

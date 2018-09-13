require "sinatra"
require "sinatra/reloader" if development?
require_relative "controllers/book_controller.rb"

run BookController

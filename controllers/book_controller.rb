class BookController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")
  set :view, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    @books = Book.getAll
    erb :"books/main"
  end

  get "/new" do
    @book = Book.new
    erb :"books/new"
  end

  post "/" do
    Book.create(params[:title], params[:body])
    redirect "/"
  end

  put "/:id" do
    Book.edit(params[:id].to_i, params[:title], params[:body])
    redirect "/"+params[:id]
  end

  delete "/:id" do
    Book.delete(params[:id].to_i)
    redirect "/"
  end

  get "/:id/edit" do
    @book = Book.find(params[:id].to_i)
    erb :"books/edit"
  end

  get "/:id" do
    arg = params[:id]
    if arg.is_int? && arg.to_i >= 0
      @book = Book.find(arg.to_i)
      erb :"books/book"
    else
      "Book not found"
    end
  end
end

class String
  def is_int?
    /\A[-+]?\d+\z/ === self
  end
end

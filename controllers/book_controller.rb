class BookController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")
  set :view, Proc.new {File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  $books = [
    {
      id: 0,
      title: "Frankenstein",
      body: "Frankenstein; or, The Modern Prometheus is a novel written by English author Mary Shelley (1797–1851) that tells the story of Victor Frankenstein, a young scientist who creates a grotesque, sapient creature in an unorthodox scientific experiment. Shelley started writing the story when she was 18, and the first edition of the novel was published anonymously in London on 1 January 1818, when she was 20. Her name first appeared on the second edition, published in France in 1823."
    },{
      id: 1,
      title: "The Odyssey",
      body: "The Odyssey is one of two major ancient Greek epic poems attributed to Homer. It is, in part, a sequel to the Iliad, the other work ascribed to Homer. The Odyssey is fundamental to the modern Western canon; it is the second-oldest extant work of Western literature, while the Iliad is the oldest. Scholars believe the Odyssey was composed near the end of the 8th century BC, somewhere in Ionia, the Greek coastal region of Anatolia."
    },{
      id: 2,
      title: "Wuthering Heights",
      body: "Wuthering Heights, Emily Brontë's only novel, was published in 1847 under the pseudonym \"Ellis Bell\". It was written between October 1845 and June 1846, Wuthering Heights and Anne Brontë's Agnes Grey were accepted by publisher Thomas Newby before the success of their sister Charlotte's novel Jane Eyre. After Emily's death, Charlotte edited the manuscript of Wuthering Heights and arranged for the edited version to be published as a posthumous second edition in 1850."
    },{
      id: 3,
      title: "Great Expectations",
      body: "Great Expectations is the thirteenth novel by Charles Dickens and his penultimate completed novel: a bildungsroman that depicts the personal growth and personal development of an orphan nicknamed Pip. It is Dickens's second novel, after David Copperfield, to be fully narrated in the first person. The novel was first published as a serial in Dickens's weekly periodical All the Year Round, from 1 December 1860 to August 1861. In October 1861, Chapman and Hall published the novel in three volumes."
    }
  ]

  get "/" do
    erb :"books/main"
  end

  get "/new" do
    @book = {
      id: "",
      title: "",
      body: ""
    }
    erb :"books/new"
  end

  post "/" do
    newBook = {
      id: $books.length,
      title: params[:title],
      body: params[:body]
    }
    $books.push(newBook)
    redirect "/"
  end

  put "/:id" do
    book = $books[params[:id].to_i]
    book[:title] = params[:title]
    book[:body] = params[:body]
    redirect "/"
  end

  delete "/:id" do
    $books.delete_at(params[:id].to_i)
    redirect "/"
  end

  get "/:id/edit" do
    @book = $books[params[:id].to_i]
    erb :"books/edit"
  end

  get "/:id" do
    arg = params[:id]
    if arg.is_int? && $books.length>arg.to_i && arg.to_i >= 0
      @book = $books[params[:id].to_i]
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

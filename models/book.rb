class Book
  attr_accessor :id, :title, :body

  def initialize t="", b=""
    @title = t
    @body = b
  end

  def self.open_connection
    conn = PG.connect(dbname: "postgres", user: "postgres")
  end

  def self.getAll
    conn = open_connection
    sql = "SELECT * FROM books"
    result = conn.exec(sql)

    booksList = result.map do |entry|
      self.parse entry
    end

    booksList
  end

  def self.find id
    conn = open_connection
    sql = "SELECT * FROM books WHERE id=#{id}"
    result = conn.exec(sql)

    self.parse(result[0])
  end

  def self.create title, body
    conn = open_connection
    sql = "INSERT INTO books (title, body) VALUES ('#{title}','#{body}')"
    conn.exec(sql)
  end

  def self.edit id, title, body
    conn = open_connection
    sql = "UPDATE books SET title = '#{title}', body = '#{body}' WHERE id=#{id}"
    conn.exec(sql)
  end

  def self.delete id
    conn = open_connection
    sql = "DELETE FROM books WHERE id=#{id}"
    conn.exec(sql)
  end

  def self.parse book_data
    book = new Book
    puts book.id, book_data["id"]
    $stdout.flush()
    book.id = book_data["id"]
    book.title = book_data["title"]
    book.body = book_data["body"]
    book
  end
end

require 'json'
require 'date'
require_relative 'book'
require_relative 'label'
require_relative 'storage'

class App
  attr_accessor :books, :labels

  include Storage

  def initialize
    @books = []
    @labels = []
    @should_exit = false
  end

  def list_books
    if @books.empty?
      puts 'No books available.'
    else
      puts 'List of books:'
      @books.each do |book|
        puts "Publisher: #{book.publisher} cover_state: #{book.cover_state}"
      end
    end
  end

  def list_labels
    if @labels.empty?
      puts 'No labels available.'
    else
      puts 'List of labels:'
      @labels.each do |label|
        puts "title: #{label.title} color: #{label.color}"
      end
    end
  end

  def add_book
    print 'Enter the title for the label: '
    title = gets.chomp
    print 'Enter the publisher of the book: '
    publisher = gets.chomp
    print 'Enter the cover state of the book: '
    cover_state = gets.chomp
    print 'Enter the published date of the book (YYYY-MM-DD): '
    published_date = Date.parse(gets.chomp)
    print 'Enter the color of the label: '
    color = gets.chomp

    book = Book.new(publisher, cover_state, published_date)
    label = Label.new(title, color, published_date)

    @books << book
    @labels << label

    puts 'Book added successfully.'
  end

  def display_options
    puts 'Options:'
    puts '1. List all books'
    puts '2. List all labels'
    puts '3. Add a book'
    puts '4. Exit'
  end

  def leave
    @should_exit = true
    save_books_labels(@books, @labels)
    exit
  end

  def execute(choice)
    case choice
    when 1
      list_books
    when 2
      list_labels
    when 3
      add_book
    when 4
      leave
    else
      puts 'Invalid choice'
    end
  end

  def run
    load_books_labels(self)
    until @should_exit
      display_options
      print 'Enter your choice: '
      choice = gets.chomp.to_i
      execute(choice)
    end
  end
end

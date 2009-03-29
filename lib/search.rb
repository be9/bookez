module Search

  def search_by_params(book_params)
    smart_search(book_params[:title], :in_titles => true) |
      smart_search((book_params[:str_authors] || "").gsub(",", " "), :in_authors => true)
  end

  def search_books_by_isbn(isbn, options={})
    # must have :in option which is :local(default) or :ozon
    model = (options[:in] == :ozon) ? OzonBook : Book
    model.find :all, :conditions => ["isbn like ?", isbn.to_s + "%"], :limit => ( options[:limit] || 10 )
  end

  def search_books(field, str)  
    # find str in book's field
    Book.all(:conditions => ["#{field} LIKE ?", "%#{str}%"])
  end

  def search_authors(str)  
    # find author by name
    Author.all(:conditions => ["name LIKE ?", "%#{str}%"])
  end

  def smart_books_search(query, params)
    def add_author_books(hash, author, min_rating, max_rating)
      author.get_books_with_position.each do |book, pos|
        add_book_by_rating( hash, book,
          min_rating + (max_rating - min_rating) * 0.5**pos)
      end
    end

    def add_book_by_rating(hash, book, rating)
      hash[book] = (hash[book] || 0) + rating
    end

    # bool params:   in_titles, in_annotations, in_authors
    books_rating = {} # book => rating
    (query || "").split.each do |word|
      if params[:in_titles] 
        search_book(:title, word).each do |book|
          add_book_by_rating(books_rating, book, 2)
        end
        
        search_book(:orig_title, word).each do |book|
          add_book_by_rating(books_rating, book, 1.5)
        end
      end
      
      if params[:in_annotations] 
        search_book(:annotation, word).each do |book|
         add_book_by_rating(books_rating, book, 1)
       end
      end
      
      if params[:in_authors]
        search_author(word).each do |author|
         add_author_books(books_rating, author, 1, 2)
       end
      end
    end

    # sort books by rating (descending)
    books_rating.sort_by { |x| -x[1] }.map { |x| x[0] }
  end

end

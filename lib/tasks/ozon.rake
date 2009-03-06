namespace :ozon do

  desc "Parse Ozon's XML file"
  task :parse => :environment do
    require 'nokogiri'

    doc = Nokogiri::XML::SAX::Document.new
    class << doc
      def start_document()
        @sql = ActiveRecord::Base.connection
        @offer = false

#          @counter = 0
      end

      def start_element(name, attrs=[])
        if name == "offer" and attrs[3] == "book" # attrs[3] - this is type
          @offer = true
          @book = { "ozon_id" => attrs[1] }
          @elem = nil
        else 
          @elem = name if @offer and
              not %{currencyId orderingTime categoryId table_of_contents}.include? name
        end
      end

      def characters(string)
        if @elem and @offer
          @book[@elem] = (@book[@elem] || "") + string
        end
      end

      def end_element(name)
        if name == "offer" and @book
          insert = "INSERT INTO `ozon_books` SET "
          @book.each do |col, val|
            insert += "#{ OzonBook.connection.quote_column_name col }=#{ OzonBook.sanitize val }, "
          end
          insert = insert[0, insert.size - 2] + ";"
          @sql.insert( insert )
          @offer = false

#            @counter += 1
#            if @counter >= 100
#              raise "end"
#            end

        end
        @elem = nil
      end

    end

    parser = Nokogiri::XML::SAX::Parser.new doc
    parser.parse_file "#{RAILS_ROOT}/div_book.xml"
    
  end

end

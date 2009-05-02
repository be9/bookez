namespace :ozon do
  desc "Clean ZIP and XML files"
  task :clean do
    sh "rm -f div_book.zip.downloading div_book.zip div_book.xml"
  end

  desc "Downloads Ozon's XML file"
  task :download => :environment do
    sh "wget -c -O div_book.zip.downloading http://www.ozon.ru/multimedia/yml/partner/div_book.zip"
    mv "div_book.zip.downloading", "div_book.zip"
    sh "unzip -o div_book.zip"
    rm "div_book.zip"
  end

  desc "Parse Ozon's XML file"
  task :parse => [:environment, :download] do
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

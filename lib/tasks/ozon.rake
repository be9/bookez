namespace :ozon do

  desc "Parse Ozon's XML file"
  task :parse => :environment do
    require 'nokogiri'

    doc = Nokogiri::XML::SAX::Document.new
    class << doc
      def start_document()
        @offer = false
      end

      def end_document()
      end

      def start_element(name, attrs=[])

        if name == "offer" and attrs[3] == "book" # attrs[3] - this is type
          @offer = true
          @book = { "ozon_id" => attrs[1] }
          @elem = nil
        else 
          @elem = name if @offer and not %{currencyId orderingTime categoryId table_of_contents}.include? name
        end
      end

      def end_element(name)
        if name == "offer" and @book
          OzonBook.populate 1, :per_query => 100 do |b|
            @book.each do |key, value|
              b.send "#{key}=", value
            end
          end
          @book = nil
          @offer = false
        end
        @elem = nil
      end

      def characters(string)
        if @elem and @offer
          @book.merge!( { @elem => string } )
        end
      end

    end

    parser = Nokogiri::XML::SAX::Parser.new doc
    parser.parse_file "#{RAILS_ROOT}/div_book.xml"
  end

end

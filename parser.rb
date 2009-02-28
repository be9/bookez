#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

require 'pp'

doc = Nokogiri::XML::SAX::Document.new
class << doc
  def start_document()
    @books = []
    @offer = false
  end

  def end_document()
  end

  def start_element(name, attrs=[])

    if name == "offer" and attrs[3] == "book" # attrs[3] - this is type
      @offer = true
      @book = {:id => attrs[1]}
    else
      if @offer and name != "orderingTime"
        @elem = name.to_sym
      end
    end
  end

  def end_element(name)
    if name == "offer"
      @books << @book
      if @books.count % 100 == 0
        puts @books.count
      end
      @offer = false
    else
      if @offer
        @elem = nil
      end
    end
  end

  def characters(string)
    if @elem and @offer
      @book[@elem] = string
    end
  end

end

parser = Nokogiri::XML::SAX::Parser.new doc
parser.parse_file "div_book.xml"

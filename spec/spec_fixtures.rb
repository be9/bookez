require 'factory_girl'

Factory.define :book do |b|
  b.title       "My Cool Book"
  b.publisher   "Myself"
  b.year        2008
  b.isbn        "5-224-04974-1"
  b.pages       900
  b.orig_title  "Lkjk lls dfjk l!"
  b.annotation  "Read it or die!"
  b.circulation 1
  b.series      "By my hand"
  b.info        "No more info"
end

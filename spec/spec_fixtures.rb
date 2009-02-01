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

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.sequence :username do |n|
  "user#{n}" 
end

Factory.sequence :authorname do |n|
  "author#{n}" 
end

Factory.define :user do |u|
  u.login       { Factory.next :username }
  u.email       { Factory.next :email } 
  u.password    "123456"
  u.password_confirmation "123456"
end

Factory.define :author do |a|
  a.name        { Factory.next :authorname }     
end

Factory.define :rate do |r|
  r.association :user, :factory => :user
  r.association :book, :factory => :book
  r.value   4
end

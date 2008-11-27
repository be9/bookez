desc "Create user `test' with password `123456'"
task :testuser => :environment do
  u = User.create!(
    :login => 'test', 
    :password => '123456', 
    :password_confirmation => '123456',
    :email => 'test@bookez.org')

  u.state = :pending
  u.activate!
end

desc "Create user `test2' with password `123456'"
task :testuser2 => :environment do
  u = User.create!(
    :login => 'test2', 
    :password => '123456', 
    :password_confirmation => '123456',
    :email => 'test2@bookez.org')

  u.state = :pending
  u.activate!
end

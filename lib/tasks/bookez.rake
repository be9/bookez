desc "Create user `test' with password `123456'"
task :testuser => :environment do
  u = User.create(
    :password => '123456', 
    :password_confirmation => '123456',
    :email => 'test@bookez.org')
  u.login = 'test'
  u.save!
end

desc "Create user `test2' with password `123456'"
task :testuser2 => :environment do
  u = User.create(
    :password => '123456', 
    :password_confirmation => '123456',
    :email => 'test2@bookez.org')
  u.login = 'test2'
  u.save!
end

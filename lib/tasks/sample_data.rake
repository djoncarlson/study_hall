require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!( 
                  :name => "Example User",
                  :email => "example@test.com",
                  :password => "foobar",
                  :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@test.com"
      password = "password"
      User.create!(:name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.students.create!(
          :name => Faker::Name.name, 
          :assignment => Faker::Lorem.sentence, 
          :instructions => Faker::Lorem.paragraph)
      end
    end
  end
end

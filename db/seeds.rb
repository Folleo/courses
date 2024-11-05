# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

MAX_OBJECTS_NUMBER = 10000

topics = []
MAX_OBJECTS_NUMBER.times do
  name = Faker::ProgrammingLanguage.name
  topics << Topic.find_or_create_by!(name:, description: "Knowledge of #{name}")
end

MAX_OBJECTS_NUMBER.times do
  author = Author.find_or_create_by!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)

  rand(MAX_OBJECTS_NUMBER).times do
    Course.find_or_create_by!(name: Faker::Lorem.sentence, author: author) do |course|
      rand(MAX_OBJECTS_NUMBER).times do
        course.topics |= [ topics.sample ]
      end
    end
  end
end

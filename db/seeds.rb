# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Post.destroy_all

puts "Seeding posts..."
Post.create!(
  title: "5 Ways to Speed up Your Rails Application",
  video_url: "https://www.youtube.com/embed/XbXBlTyekQ8?si=uX53TAu3TnzReqUF",
  created_at: Faker::Time.backward(days: 7),
  description: "In this video, we will explore 5 effective ways to speed up your Ruby on Rails application. From optimizing database queries to leveraging caching techniques, these tips will help you improve the performance of your app and provide a better user experience.",
  updated_at: Time.now,
  pro: true
)

Post.create!(
  title: "Learn Ruby on Rails -  Full Course (CREATE INSTAGRAM)",
  video_url: "https://www.youtube.com/embed/DhxLOC-9kW0?si=eIV_CU0rz-WPKsLK",
  created_at: Faker::Time.backward(days: 3),
  description: "In this comprehensive course, we will build a fully functional Instagram clone using Ruby on Rails. You will learn about models, views, controllers, and how to integrate user authentication.",
  updated_at: Time.now,
)
Post.create!(
  title: "Rails 8 Course - Beginner to Intermediate",
  video_url: "https://www.youtube.com/embed/sHBJiBimlGc?si=as8gpmaSPIfhQt_d",
  created_at: Faker::Time.backward(days: 5),
  description: "In this course, we will take your Ruby on Rails skills to the next level. You will learn about advanced topics such as API development, background jobs, and performance optimization.",
  updated_at: Time.now,
  pro: true
)
Post.create!(
  title: "How to Deploy Rails 8 with Kamal to DigitalOcean",
  video_url: "https://www.youtube.com/embed/9mHGKBoYeNI?si=EECybhpr1TdTbTXS",
  created_at: Faker::Time.backward(days: 7),
  description: "In this tutorial, we will learn how to deploy a Rails 8 application using Kamal to DigitalOcean. We will cover the entire process from setting up the server to configuring the application.",
  updated_at: Time.now,
)

Category.create!([
  { name: "Ruby" },
  { name: "Rails" },
  { name: "JavaScript" },
  { name: "DevOps" }
])


puts "Email: #{Rails.application.credentials.dig(:admin, :email).inspect}"

admin_email = Rails.application.credentials.dig(:admin, :email)
admin_password = Rails.application.credentials.dig(:admin, :password)

if admin_email.present? && admin_password.present?
  unless User.exists?(email: admin_email)
    User.create!(
      email: admin_email,
      password: admin_password,
      password_confirmation: admin_password,
    )
    puts "✅ Admin user created"
  else
    puts "ℹ️ Admin user already exists"
  end
else
  puts "⚠️ Admin credentials are not found in credentials file"
end

puts "✅ Seeding completed."

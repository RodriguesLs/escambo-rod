# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = ["Animais e acessórios", "Esportes", "Para a sua casa", 
              "Eletrônicos e celulares", "Música e hobbies", "Bebês e crianças",
              "Moda e beleza", "Veículos e Barcos", "Imóveis", "Empregos e negócios"]
              
categories.each do |category|
    Category.find_or_create_by(description: category)
end

#################E

Admin.create!(name: "Eu eu mesmo e Irene", role: 0, 
                email: "admin@admin.com", password: "190195", password_confirmation: "190195")
                
  member = Member.new(email: "member@member.com", password: "190195", password_confirmation: "190195")
  member.build_profile_member
  member.profile_member.first_name = Faker::Name.first_name
  member.profile_member.second_name = Faker::Name.last_name
  member.save!
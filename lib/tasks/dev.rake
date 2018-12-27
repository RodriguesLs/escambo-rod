namespace :dev do
  
  
  desc "Setup development"
  task setup: :environment do
    
    images_path = Rails.root.join('public', 'system')
    p "Executando setups"
      %x(rake db:drop)
      %x(rm -rf "#{images_path}") #Apagando pasta public/system
      %x(rake db:create)
      %x(rake db:migrate)
      %x(rake db:seed)
      %x(rake dev:generate_admins)
      %x(rake dev:generate_members)
      %x(rake dev:generate_ads)
    p "Setups executados"
  
  end

  desc "Cria Administradores Fake"
  task generate_admins: :environment do
    p "Cadastrando ADMINISTRADORES..."

    10.times do
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456",
        role: [0,0,1,1,1].sample
      )
    end

    p "ADMINISTRADORES cadastrados com sucesso!"
  end

  
  desc "Cria Membros Fake"
  task generate_members: :environment do
    p "Cadastrando Membros..."

    100.times do
      Member.create!(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
    end

    p "Members cadastrados com sucesso!"
  end

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    p "Cadastrando ANÚNCIOS..."
    
    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: markdown_fake,
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'paper_pictures',
                  "#{Random.rand(8)}.jpg"), 'r')
      )
    end
    
    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: markdown_fake,
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'paper_pictures',
                  "#{Random.rand(8)}.jpg"), 'r')
      )
    end
    p "ANÚNCIOS cadastrados com sucesso!"
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
end
namespace :dev do
  
  desc "Setup development"
  task setup: :environment do
    
    images_path = Rails.root.join('public', 'system')
    p "Executando setups"
      %x(rake db:drop)
    
    if Rails.env.development?
      p %x(rm -rf "#{images_path}") #Apagando pasta public/system
    end
    
    p %x(rake db:create)
    p %x(rake db:migrate)
    p %x(rake db:seed)
    p %x(rake dev:generate_admins)
    p %x(rake dev:generate_members)
    p %x(rake dev:generate_ads)
    p %x(rake dev:generate_comments)
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
      member = Member.new(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
      
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name
      member.save!
      
    end

    p "Members cadastrados com sucesso!"
  end

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    p "Cadastrando ANÚNCIOS..."
    
    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([3,4,5].sample),
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
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([3,4,5].sample),
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
  
  desc "Cria comentários Fake"
  task generate_comments: :environment do
    p "Cadastrando comentários..."

    Ad.all.each do |ad|
      (Random.rand(3)).times do
        Comment.create!(
          body: Faker::Lorem.paragraph([1,2,3].sample),
          member: Member.all.sample,
          ad: ad
          )
      end
    end
  end
end
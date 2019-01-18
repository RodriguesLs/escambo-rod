class Ad < ActiveRecord::Base
  
  ratyrate_rateable 'quality'
  
  before_save :md_to_html
  
  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments
  
  #Validates
  validates :title, :description_md, :description_short, :price, :category, :finish_date, presence: true
  
  scope :descending_order, -> () {order(created_at: :desc)}
  scope :search, -> (q, page) { where("title LIKE ?", "%#{q}%").page(page).per(6) }
  
  scope :random, ->(quantity) {
    if Rails.env.production?
      limit(quantity).order("RAND()") # MySQL
    else
      limit(quantity).order("RANDOM()") # SQLite
    end
  }  
  
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, 
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem Money_rails
  monetize :price_cents
  
  private
  
  def md_to_html
  
    options = {
      filter_html: true,
      link_attributes: {
        rel: "nofollow",
        target: "_blank"
      }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

  renderer = Redcarpet::Render::HTML.new(options)
  markdown = Redcarpet::Markdown.new(renderer, extensions)

  self.description = markdown.render(self.description_md)
  end
end
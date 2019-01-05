class Ad < ActiveRecord::Base
  
  before_save :md_to_html
  
  belongs_to :member
  belongs_to :category, counter_cache: true
  
  #Validates
  validates :title, :description_md, :description_short, :price, :category, :finish_date, presence: true
  
  scope :descending_order, -> () {order(created_at: :desc)}
  scope :search, -> (q, page) { where("title LIKE ?", "%#{q}%").page(page).per(6) }
  
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, 
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem Money_rails
  monetize :price_cents
  
  protected
  
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

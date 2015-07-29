class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :billing_users, class_name: "User", foreign_key: :billing_id
  has_many :shipping_users, class_name: "User", foreign_key: :shipping_id

  validates :street_address, :city, :state, :presence => true
  validates :street_address, :city, :length => {:maximum => 64}
  validates :user, :presence => true

  # before_create :check_city

  def full_address
    "#{self.street_address}, #{self.city.name}, #{self.state.name} #{self.zip_code}"
  end

  # def check_city
  # 	city = params[:address]["city"]
  #   result = City.select(:id).where("name = ?", city)
  #   if result.first
  #     result= result.first.id
  #   else
  #     c = City.new(name: city)
  #     c.save
  #     c.id
  #   end
  # end

end

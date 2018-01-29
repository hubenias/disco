class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_lines

  # NOTE: created just for convenience, does not covered by specs
  def update_price
    self.price = order_lines.map(&:price).reduce(:+)
    save
  end

end
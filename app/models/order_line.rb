class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  before_validation :calculate_price

  # NOTE: created just for convenience, does not covered by specs
  def calculate_price
    self.price = item.price * qty if item
  end

end
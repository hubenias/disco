class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  before_validation :calculate_price
  after_save :update_order_price

  # NOTE: created just for convenience, does not covered by specs
  def calculate_price
    self.price = item.price * qty if item
  end

  def update_order_price
    order.update_price
  end

end
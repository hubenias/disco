module Discount
  class ItemsQty
    PERCENTAGE = 0.05
    DISCOUNT_QTY = 3

    class << self

      def calculate(order)
        discount = 0
        order.order_lines.each do |l|
          next if l.qty < DISCOUNT_QTY
          discount += l.price * PERCENTAGE
        end
        discount
      end
    end
  end
end
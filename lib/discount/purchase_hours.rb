module Discount
  class PurchaseHours
    PERCENTAGE = 0.03
    VALUE = (5..7).freeze

    def self.calculate(order)
      # NOTE: in real world application order may have different states, e.g.
      # new/draft/sent so it makes sense to prefer usage special column(e.g sent_at)
      # instead of created_at
      if order.created_at && VALUE.include?(order.created_at.hour)
        (order.price || 0) * PERCENTAGE
      else
        0
      end
    end
  end
end
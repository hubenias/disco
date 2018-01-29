module Discount
  class UserLocation
    PERCENTAGE = 0.04
    VALUE = 'North America'.freeze

    def self.calculate(order)
      if order.user && order.user.location == VALUE
        (order.price || 0) * PERCENTAGE
      else
        0
      end
    end
  end
end

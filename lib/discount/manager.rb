require 'items_qty'
require 'user_location'
require 'purchase_hours'

module Discount
  class Manager
    DISCOUNTS = %w(ItemsQty UserLocation PurchaseHours).freeze

    # such notation means: ItemsQty discount has precedence over UserLocation
    # i.e. only ItemsQty will be applied if they all are applicable
    # according to the task following line should be used though some discounts
    # weren't implemented:
    # DISCOUNT_PRIORITIES = { 'NewYear' => ['UserLocation', 'PurchaseHours'] }.freeze
    DISCOUNT_PRIORITIES = { 'ItemsQty' => ['UserLocation'] }.freeze
    class << self
      def calculate(order)
        applicable_discounts = {}
        DISCOUNTS.each do |name|
          klass = "Discount::#{name}".constantize # no rescue no cry)
          amount = klass.calculate(order)
          applicable_discounts[name] = amount unless amount.zero?
        end
        discounts_to_use = prioritize(applicable_discounts)
        discounts_to_use.values.reduce(:+) || 0
      end

      private

      def prioritize(discounts)
        DISCOUNT_PRIORITIES.each do |d, list_to_remove|
          next unless discounts.key?(d)
          discounts.delete_if { |name, _| list_to_remove.include? name }
        end
        discounts
      end
    end
  end
end

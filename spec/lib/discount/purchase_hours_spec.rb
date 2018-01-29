require 'rails_helper'
require 'discount/purchase_hours'

RSpec.describe Discount::PurchaseHours do
  subject { described_class }

  describe '.calculate' do
    let(:order) { Order.first }
    let(:time) { Time.zone.parse('2018-01-20 00:00:00').utc }
    context 'when order is not created' do
      it 'returns 0' do
        expect(subject.calculate(Order.new)).to eq(0)
      end
    end

    context 'for order made not in discount time zone' do
      it 'returns 0 for order made earlier' do
        order_time = time + (subject::VALUE.first - 1).hour
        order.created_at = order_time
        expect(subject.calculate(order)).to eq(0)
      end

      it 'returns 0 for order made later' do
        order_time = time + (subject::VALUE.last + 1).hour
        order.created_at = order_time
        expect(subject.calculate(order)).to eq(0)
      end
    end

    context 'for order within discount hours' do
      it 'returns proper discount' do
        order_time = time + subject::VALUE.last.hour
        order.created_at = order_time
        discount = order.price * subject::PERCENTAGE
        expect(subject.calculate(order)).to eq(discount)
      end
    end
  end
end

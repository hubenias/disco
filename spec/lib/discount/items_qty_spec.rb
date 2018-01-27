require 'rails_helper'
require 'discount/items_qty'

RSpec.describe Discount::ItemsQty do
  subject { described_class }

  describe '.calculate' do
    let(:order) { Order.create!(user: User.first) }
    let(:disc_qty) { subject::DISCOUNT_QTY }
    context 'when order is empty' do
      it 'returns 0' do
        expect(subject.calculate(order)).to eq(0)
      end
    end

    context 'when order has less than DISCOUNT_QTY same items' do
      before do
        OrderLine.create!(order: order, item: Item.first, qty: disc_qty - 1)
      end
      it 'returns 0' do
        expect(subject.calculate(order)).to eq(0)
      end
    end

    context 'when order has DISCOUNT_QTY same items' do
      before do
        OrderLine.create!(order: order, item: Item.first, qty: disc_qty)
      end
      it 'returns calculated discount' do
        ol = order.order_lines.first
        discounted_amount = ol.price * subject::PERCENTAGE
        expect(subject.calculate(order)).to eq(discounted_amount)
      end

      context 'and several order_lines exist' do
        before do
          OrderLine.create!(order: order, item: Item.last, qty: disc_qty + 1)
        end
        it 'calculates discount properly' do
          line = order.order_lines.first
          line2 = order.order_lines.last
          discounted_amount = (line.price + line2.price) * subject::PERCENTAGE
          expect(subject.calculate(order)).to eq(discounted_amount)
        end
      end
    end
  end
end
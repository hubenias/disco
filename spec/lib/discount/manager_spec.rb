require 'rails_helper'
require 'discount/manager'

RSpec.describe Discount::Manager do
  subject { described_class }

  describe '.calculate' do
    let(:order) do
      order = Order.first
      # we have to guarantee that all discounts aren't applicable as we're going
      # to mock calls to needed discounts
      time = Time.zone.parse('2018-01-20 00:00:00').utc
      order_time = time + (Discount::PurchaseHours::VALUE.first - 1).hour
      order.created_at = order_time
      order
    end

    context 'for empty order' do
      it 'returns 0' do
        expect(subject.calculate(Order.new)).to eq(0)
      end
    end

    describe 'runs all discounts' do
      it 'runs ItemsQty' do
        allow(Discount::ItemsQty).to receive(:calculate).and_return(123.45)
        expect(subject.calculate(order)).to eq(123.45)
      end

      it 'runs UserLocation' do
        allow(Discount::UserLocation).to receive(:calculate).and_return(123.45)
        expect(subject.calculate(order)).to eq(123.45)
      end

      it 'runs PurchaseHours' do
        allow(Discount::PurchaseHours).to receive(:calculate).and_return(123.45)
        expect(subject.calculate(order)).to eq(123.45)
      end

      it 'sums all applicable' do
        allow(Discount::UserLocation).to receive(:calculate).and_return(123.47)
        allow(Discount::PurchaseHours).to receive(:calculate).and_return(654.3)
        expect(subject.calculate(order)).to eq(777.77)
      end
    end

    describe 'discounts priorities' do
      context 'for few applicable discounts' do
        it 'returns higher priority' do
          allow(Discount::ItemsQty).to receive(:calculate).and_return(123.47)
          allow(Discount::UserLocation).to receive(:calculate).and_return(654.3)
          expect(subject.calculate(order)).to eq(123.47)
        end

        it 'sums higher priority discount and other applicable' do
          allow(Discount::ItemsQty).to receive(:calculate).and_return(123.47)
          allow(Discount::PurchaseHours).to receive(:calculate).and_return(654.3)
          allow(Discount::UserLocation).to receive(:calculate).and_return(1000)

          expect(subject.calculate(order)).to eq(777.77)
        end
      end
    end
  end
end

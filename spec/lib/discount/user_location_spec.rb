require 'rails_helper'
require 'discount/user_location'

RSpec.describe Discount::UserLocation do
  subject { described_class }

  describe '.calculate' do
    let(:order) { Order.first }
    context 'when order is not  created' do
      it 'returns 0' do
        expect(subject.calculate(Order.new)).to eq(0)
      end
    end

    context 'when normal user makes order' do
      it 'returns 0' do
        expect(subject.calculate(order)).to eq(0)
      end
    end

    context 'when user from specified location makes order' do
      before { order.update(user: User.last) }
      it 'returns proper discount' do
        discount = order.price * subject::PERCENTAGE
        expect(subject.calculate(order)).to eq(discount)
      end
    end
  end
end

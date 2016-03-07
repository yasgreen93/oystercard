require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  it 'should initialize with a balance of 0' do
    expect(card.balance).to be_zero
  end

end

require 'oystercard'

describe Oystercard do
  it 'should initialize with a balance of 0' do
    expect(subject.balance).to be_zero
  end

end

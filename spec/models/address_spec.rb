require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { build(:address) }

  it 'has a valid factory' do
    expect(address).to be_valid
  end

  it { is_expected.to(validate_presence_of(:zipcode)) }
  it { is_expected.to(validate_presence_of(:street)) }
  it { is_expected.to(validate_presence_of(:neighboorhood)) }
  it { is_expected.to(validate_presence_of(:city)) }
  it { is_expected.to(validate_presence_of(:state)) }
  it { is_expected.to(validate_length_of(:street).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:complement).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:neighboorhood).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:city).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:state).is_equal_to(2)) }
  it { is_expected.to(validate_presence_of(:zipcode)) }
  it { is_expected.to(validate_numericality_of(:zipcode)) }
  it { is_expected.to(belong_to(:addressable)) }
end

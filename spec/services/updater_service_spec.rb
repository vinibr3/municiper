require  'rails_helper'

RSpec.describe Residents::UpdaterService, type: :service do
  let(:resident) { create(:resident) }
  let(:address_attributes) { { 0 => attributes_for(:address) } }
  let(:valid_params) { attributes_for(:resident).merge(addresses_attributes: address_attributes) }

  subject { Residents::UpdaterService.call(valid_params: valid_params, id: resident.id) }

  it 'persist resident' do
    expect(subject).to be_persisted
  end

  it 'update full_name' do
    expect(subject.full_name).to eq(valid_params[:full_name])
  end

  it 'update addresses' do
    zipcodes = address_attributes.values.map{|a| a[:zipcode] }

    expect(subject.addresses.map(&:zipcode)).to eq(zipcodes)
  end
end

require  'rails_helper'

RSpec.describe Residents::CreatorService, type: :service do
  let(:address_attibutes) { { 0 => attributes_for(:address) } }
  let(:valid_params) { attributes_for(:resident).merge(addresses_attributes: address_attibutes) }

  subject { Residents::CreatorService.call(valid_params: valid_params) }

  it 'create resident' do
    expect(subject.first).to be_persisted
  end
end

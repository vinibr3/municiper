require 'rails_helper'

RSpec.describe ResidentsController, type: :controller do
  context 'GET index' do
    before { get :index }

    it { is_expected.to(route(:get, '/residents').to(action: :index)) }
    it { is_expected.to(render_template(:index)) }
    it { is_expected.to(render_with_layout(:application)) }
    it { is_expected.to(respond_with(:ok)) }
  end

  context 'POST create' do
    let(:params) { attributes_for(:resident) }

    before { post :create, params: { resident: params }, format: :js }

    it { is_expected.to(route(:post, '/residents').to(action: :create)) }
    it { is_expected.to(render_template(:create)) }
    it { is_expected.to(respond_with(:ok)) }

    it do
      params = { resident: attributes_for(:resident) }

      is_expected.to permit(:full_name, :document, :health_card_document, :email,
                            :phone, :birthdate, :status, :photo).
        for(:create, params: params).
        on(:resident)
    end
  end
end

# frozen_string_literal: true

class ResidentsController < ApplicationController
  def index
    @q = Resident.ransack(params[:q])
    @residents = @q.result(distinct: true)
                   .includes(:addresses)
                   .page(params[:page])
  end

  def create
    @resident = Resident.new(valid_params)
    @addresses =
      valid_params[:addresses_attributes].to_h.map{|k, v| @resident.addresses.build(v) }
  end

  private

  def valid_params
    addresses_attributes =
      %i[id zipcode street complement neighboorhood city state ibge_code]

    params.require(:resident)
          .permit(:full_name, :document, :health_card_document, :email, :phone,
                  :birthdate, :status, :photo, addresses_attributes: addresses_attributes)
  end
end

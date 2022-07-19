# frozen_string_literal: true

class ResidentsController < ApplicationController
  def index
    @q = Resident.ransack(params[:q])
    @residents = @q.result(distinct: true)
                   .includes(:addresses)
                   .page(params[:page])
  end

  def create
    @resident, @addresses =
      Residents::CreatorService.call(valid_params: valid_params)
  end

  def update
    @resident = Resident.find(params[:id])
    @resident.assign_attributes(valid_params)
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

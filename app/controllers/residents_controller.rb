# frozen_string_literal: true

class ResidentsController < ApplicationController
  def index
    @q = Resident.ransack(params[:q])
    @residents = @q.result(distinct: true)
                   .includes(:addresses)
                   .page(params[:page])
  end

  def create
    @resident = Resident.create(valid_params)
  end

  private

  def valid_params
    params.require(:resident)
          .permit(:full_name, :document, :health_card_document, :email,
                  :phone, :birthdate, :status, :photo)
  end
end

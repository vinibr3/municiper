# frozen_string_literal: true

class ResidentsController < ApplicationController
  def index
    @q = Resident.ransack(params[:q])
    @residents = @q.result(distinct: true)
                   .includes(:addresses)
                   .page(params[:page])
  end
end

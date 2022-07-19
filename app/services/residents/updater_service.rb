# frozen_string_literal: true

class Residents::UpdaterService < ApplicationService
  def call
    if @resident.update(@params)
      send_status_update_mail_to_resident if @status != @resident.status
    end
    @resident
  end

  private

  def initialize(args)
    @resident = Resident.find(args[:id])
    @params = args[:valid_params]
    @status = @resident.status
  end

  def send_status_update_mail_to_resident
    ResidentMailer.with(resident: @resident).status_update.deliver_now
  end
end

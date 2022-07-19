# frozen_string_literal: true

class Residents::CreatorService < ApplicationService
  def call
    resident = Resident.new(@params)
    send_registration_mail_to(resident) if resident.save
    [resident, addresses(resident)]
  end

  private

  def initialize(args)
    @params = args.dig(:valid_params)
    @addresses_attributes = @params[:addresses_attributes].try(:values) || []
  end

  def addresses(resident)
    @addresses_attributes.map do |address_attibutes|
                            address = resident.addresses.build(address_attibutes)
                            address.valid?
                            address
                          end
  end

  def send_registration_mail_to(resident)
    ResidentMailer.with(resident: resident).registration.deliver_later
  end
end

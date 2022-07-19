# frozen_string_literal: true

class ResidentMailer < ApplicationMailer
  helper :resident

  def registration
    @resident = params[:resident]
    @address = @resident.addresses.first

    mail(to: @resident.email, subject: t('.subject'))
  end
end

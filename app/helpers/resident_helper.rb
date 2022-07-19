module ResidentHelper
  def format_brazilian_health_card_number(value)
    "#{value[0,3]} #{value[3,4]} #{value[7,4]} #{value[11,4]}"
  end

  def format_document(value)
    "#{value[0,3]}.#{value[3,3]}.#{value[6,3]}-#{value[9,3]}"
  end

  def ensure_address_for(object)
    object.addresses.first || object.addresses.build
  end
end

class BrazilianHealthCardNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid, options) unless validate?(value)
  end

  private

  def validate?(value)
    return false if value.to_s.length != 15

    repeated_digits_regex = /\A(\d)\1*\z/
    return false if value.match?(repeated_digits_regex)

    digits = value.chars.map(&:to_i)
    first_number = digits.first

    return validate_number?(digits) if first_number.in?([1, 2])
    return validate_number_as_temporary?(digits) if first_number.in?([7, 8, 9])
    false
  end

  def validate_number?(digits)
    pis = digits.first(11)
    length = digits.length
    sum = pis.map.with_index {|n, i| n * (length - i) }.sum
    mod = sum % 11
    dv = mod.zero? ? 0 : 11 - mod

    builded_pis = if dv == 10
                    dv = 11 - ((sum + 2) % 11)
                    "#{pis.join}001#{dv}"
                  else
                    "#{pis.join}000#{dv}"
                  end

    digits.join == builded_pis
  end

  def validate_number_as_temporary?(digits)
    length = digits.length
    sum = digits.map.with_index {|n, i| n * (length - i) }.sum

    sum.multiple_of?(11)
  end
end

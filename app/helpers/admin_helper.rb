# Helper for admin view
module AdminHelper

  def sign_for(value)
    return '± 0' if value.zero?
    return ('+' + value.to_s) if value.positive?

    value.to_s
  end
end

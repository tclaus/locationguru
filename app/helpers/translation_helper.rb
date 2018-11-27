# frozen_string_literal: true

module TranslationHelper
  # Translate location_type
  def trLocationType(id)
    Translation.localize(id, 'LocationType', I18n.locale)
  end

  def trKindType(id)
    Translation.localize(id, 'KindType', I18n.locale)
  end

  def trCateringType(id)
    Translation.localize(id, 'CateringType', I18n.locale)
  end
end

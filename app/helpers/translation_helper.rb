module TranslationHelper

  # Translate location_type
  def trLocationType(id)
    Translation.localize(id,'LocationType','de')
  end

  def trKindType(id)
    Translation.localize(id,'KindType','de')
  end

  def trCateringType(id)
    Translation.localize(id,'CateringType','de')
  end
end

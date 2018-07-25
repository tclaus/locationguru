class Translation < ApplicationRecord
  
  def self.localize(id, type, language_id)
    translatedText = Translation.where(text_id: id,
                                       category: type,
                                       language_id: language_id).take

    translatedText.translation if translatedText
  end
end

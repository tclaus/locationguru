# frozen_string_literal: true

class Translation < ApplicationRecord
  def self.localize(id, type, language_id)
    translated_text = Translation.where(text_id: id,
                                       category: type,
                                       language_id: language_id).take

    translated_text&.translation
  end
end

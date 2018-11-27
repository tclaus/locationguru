# frozen_string_literal: true

require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  test 'get a translation' do
    translatedText = Translation.localize(1, 'CateringType', 'de')
    assert_not_nil translatedText, 'A translated text should be returned'
  end
end

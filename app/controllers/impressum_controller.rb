# frozen_string_literal: true

##
# Static page controller (Company impressum)
class ImpressumController < ApplicationController
  def show
    render 'impressum/impressum'
  end
end

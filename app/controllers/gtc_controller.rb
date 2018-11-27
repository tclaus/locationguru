# frozen_string_literal: true

##
# General Terms and Conditions static page handler
class GtcController < ApplicationController
  def show_gtc
    render 'gtc/gtc'
  end
end

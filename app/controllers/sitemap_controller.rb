# frozen_string_literal: true

## Generates a sitemap of all locations
class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml do
        @locations = Location.activated.order(updated_at: :desc)
      end
    end
  end
end

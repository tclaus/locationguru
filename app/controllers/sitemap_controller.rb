# frozen_string_literal: true

## Generates a sitemap of all locations
class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml {@locations = Location.where(active: true)
                          .order(updated_at: :desc)}
    end
  end
end

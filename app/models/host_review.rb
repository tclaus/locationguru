# frozen_string_literal: true

class HostReview < Review
  belongs_to :host, class_name: 'Host'
end

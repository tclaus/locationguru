class HostReview < Review
  belongs_to :host, class_name: "Host"
end

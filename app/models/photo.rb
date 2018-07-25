class Photo < ApplicationRecord
  belongs_to :location

  has_attached_file :image, { styles: {
    original: "1440x900>",
    regular: "1200x1200>",
    medium: "480x320>",
    thumb: "100x100>"
  }
}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end

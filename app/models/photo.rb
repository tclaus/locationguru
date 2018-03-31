class Photo < ApplicationRecord
  belongs_to :location

  has_attached_file :image, { styles: {
    original: "1440x900>",
    regular: "1200x1200>",
    medium: "480x320>",
    thumb: "100x100>"
  },
  hash_secret: "6e819d87948bdb4f17a479b68cf03e6cd920d696716ef1324e705734fe1bbdd630bd2903fd23e532919ca79a8a6f1298127fc0c528fb48fe540a1b103d5af5f2"
}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end

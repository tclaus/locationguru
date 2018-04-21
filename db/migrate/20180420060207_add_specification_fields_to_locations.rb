class AddSpecificationFieldsToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :isForPrivateParties, :boolean, null: false, default: false
    add_column :locations, :isForClubbing, :boolean, null: false, default: false
    add_column :locations, :isForWeddings, :boolean, null: false, default: false
    add_column :locations, :isForPhotoFilm, :boolean, null: false, default: false
    add_column :locations, :isForBusiness, :boolean, null: false, default: false
    add_column :locations, :isForEscapeRoomGames, :boolean, null: false, default: false
    add_column :locations, :isForConferences, :boolean, null: false, default: false
    add_column :locations, :isForBachelorParties, :boolean, null: false, default: false
    add_column :locations, :isForChristmasParties, :boolean, null: false, default: false
  end
end

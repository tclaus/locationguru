# frozen_string_literal: true

module LocationsHelper
  def suitable_for(location)
    text = []
    text << t('.isForPrivateParties') if location.isForPrivateParties
    text << t('.isForWeddings') if location.isForWeddings
    text << t('.isForClubbing') if location.isForClubbing
    text << t('.isForPhotoFilm') if location.isForPhotoFilm
    text << t('.isForBusiness') if location.isForBusiness
    text << t('.isForEscapeRoomGames') if location.isForEscapeRoomGames
    text << t('.isForBachelorParties') if location.isForBachelorParties
    text << t('.isForChristmasParties') if location.isForChristmasParties
    text << location.suitableForText unless location.suitableForText.blank?
    text.join(', ')
  end

  def kind_type_for_select
    KindType.all.map { |kind_type| [trKindType(kind_type.id), kind_type.id] }
  end

  def location_type_for_select
    LocationType.all.map { |location_type| [trLocationType(location_type.id), location_type.id] }
  end
end

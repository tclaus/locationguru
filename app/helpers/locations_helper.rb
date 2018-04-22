module LocationsHelper
  def suitable_for(location)
    text = []
    if location.isForPrivateParties
      text << t('.isForPrivateParties')
    end
    if location.isForWeddings
      text << t('.isForWeddings')
    end
    if location.isForClubbing
      text << t('.isForClubbing')
    end
    if location.isForPhotoFilm
      text << t('.isForPhotoFilm')
    end
    if location.isForBusiness
      text << t('.isForBusiness')
    end
    if location.isForEscapeRoomGames
      text << t('.isForEscapeRoomGames')
    end
    if location.isForBachelorParties
      text << t('.isForBachelorParties')
    end
    if location.isForChristmasParties
      text << t('.isForChristmasParties')
    end
    if !location.suitableForText.blank?
        text << location.suitableForText
    end
    text.join(', ')
  end
end

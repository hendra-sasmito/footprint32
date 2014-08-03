class PhotoAlbumNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #record.errors[attribute] << " is not valid" if value == "Profile Album"
    unless value != "Profile Album"
      record.errors.add(attribute, :name, options.merge(:value => value))
    end
  end
end
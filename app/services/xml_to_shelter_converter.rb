class XmlToShelterConverter

  def self.convert(shelter)
    {
      id: shelter.id,
      name: shelter.name,
      address1: shelter.address1,
      address2: shelter.address2,
      city: shelter.city,
      state: shelter.state,
      zip: shelter.zip,
      country: shelter.country,
      latitude: shelter.latitude,
      longitude: shelter.longitude,
      phone: shelter.phone,
      fax: shelter.fax,
      email: shelter.email
    }
  end

end
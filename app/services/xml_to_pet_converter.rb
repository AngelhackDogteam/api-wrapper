class XmlToPetConverter

  def self.convert(pet)
    {
      photos: pet.photos,
      name: pet.name,
      id: pet.id,
      mix: pet.mix,
      age: pet.age,
      shelter_id: pet.shelter_id,
      shelter_pet_id: pet.shelter_pet_id,
      sex: pet.sex,
      size: pet.size,
      description: pet.description,
      breeds: pet.breeds,
      status: pet.status,
      options: pet.options
    }  
  end

end
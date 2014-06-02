class PetProxy
  attr_accessor :id, :name, :animal, :mix, :age, :shelter_id, :shelter_pet_id,
      :sex, :size, :description, :last_update, :status, :photos, :breeds, :options

  def initialize(data)
    @id = data['id']['$t']
    @name = data['name']['$t']
    @animal = data['animal']['$t']
    @mix = data['mix']['$t']
    @age = data['age']['$t']
    @shelter_id = data['shelterId']['$t']
    @shelter_pet_id = data['shelterPetId']
    @sex = data['sex']['$t']
    @size = data['size']['$t']
    @description = data['description']['$t'] 
    @last_update = data['lastUpdate']['$t']
    @status =  data['status']['$t']
    @breeds = [data['breeds']['breed']].flatten.map{|b| b["$t"]}
    @options = [data['options']['option']].flatten.map{|b| b["$t"]}
    parse_photos(data['media']['photos'].try(:[], 'photo'))
  end

  def self.multiple(json)
    return [] if json.try(:[], 'pets').try(:[], 'pet').nil?
    json["pets"]["pet"].map do |node|
      PetProxy.new(node)
    end
  end

  private

  def parse_photos(array)
    @photos = []
    return if array.nil?
    array.each do |photo|
      add_photo(photo['@id'], photo['@size'], photo['$t'])
    end
  end

  def add_photo(id, size, url)
    photo = @photos.find { |photo| photo.id == id } || Photo.new(id)
    case size
    when "x"
      photo.large = url
    when "pn"
      photo.medium = url
    when "fpm"
      photo.small = url
    when "pnt"
      photo.thumbnail = url
    when "t"
      photo.tiny = url
    end
    @photos << photo unless @photos.include?(photo)
  end

end
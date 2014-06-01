class Photo
  attr_accessor :id, :large, :medium, :small, :thumbnail, :tiny

  def initialize(id)
    @id = id
  end
end
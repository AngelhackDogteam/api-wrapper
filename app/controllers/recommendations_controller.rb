class RecommendationsController < ApplicationController
  respond_to :json

  def index
    unless params[:location]
      render_400 and return
    end

    # size=1
    # agility=2
    # train=3
    # shed=2

    size = params[:size].to_i
    agility = params[:agility].to_i
    train = params[:train].to_i
    shed = params[:shed].to_i

    breed_dictionary = {:'low' => 1, :'medium' => 2, :'high' => 3}
    breed_ratings = []
    
    space_score = 0
    agility_score = 0
    train_score = 0
    shed_score = 0

    breed_database.each do |dog|
      i = dog[1][6][1].to_sym
      if (size - breed_dictionary[i]).abs == 0
        size_score = 1
      elsif (size - breed_dictionary[i]).abs == 1
        size_score = 0.5
      else
        size_score = 0
      end

      #Agility
      i = dog[1][7][1].to_sym
      if (agility - breed_dictionary[i]).abs == 0
        agility_score = 1
      elsif (agility - breed_dictionary[i]).abs == 1
        agility_score = 0.5
      else
        agility_score = 0
      end

      #Train
      i = dog[1][0][1].to_sym
      if (train - breed_dictionary[i]).abs == 0
        train_score = 1
      elsif (train - breed_dictionary[i]).abs == 1
        train_score = 0.5
      else
        train_score = 0
      end

      #Shed
      i = dog[1][1][1].to_sym
      if (shed - breed_dictionary[i]).abs == 0
        shed_score = 1
      elsif (shed - breed_dictionary[i]).abs == 1
        shed_score = 0.5
      else
        shed_score = 0
      end

      breed_score = size_score+agility_score+train_score+shed_score

      breed_ratings << [dog[0], breed_score]
    end
    breed_ratings.sort! { |x,y| y[1] <=> x[1] }
    
    top_5_breeds = breed_ratings[0..4].map{|breed| breed[0]}
    age = params[:age]  
    location = params[:location]
    sex = params[:sex] #Male/Female/no preference (no request!)
    tries ||= 10
    begin
      # binding.pry
      options = {age: age, location: location, sex: sex, breeds: top_5_breeds}.keep_if {|k,v| !v.nil?}
      pets = petfinder.find_pets('dog', params[:location], options)
      @pets = []
      pets.each do |pet|        
        @pets << XmlToPetConverter.convert(pet)
      end
      render json: @pets and return
    rescue Excon::Errors::SocketError
      unless (tries -= 1).zero?
        retry 
      else
        render_400 and return
      end
    end
  end
end

  

  # age = 'Baby' #baby, young, adult, senior
  # location = '11753'
  # sex = 'M' #Male/Female/no preference (no request!)
  # url = 'http://hidden-dawn-1745.herokuapp.com/breeds.json?location=%s' % location
  # if age!='':
  #   url=url+'&age=%s' % age
  # if (sex=='M') or (sex=='F'):
  #   url=url+'&sex=%s' % sex
  # if sex=='NP':
  #   url=url
  # for breed in top_5_breeds:
  #   url=url+'&breed[]=%s' % breed[0]
  

  # #Make request
  # r = requests.get(url)
  # json_stuff = r.json()

  # return render(request, 'test_page.html', {'top_5_breeds':top_5_breeds, 
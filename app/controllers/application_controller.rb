class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def petfinder
    @petfinder || Petfinder::Client.new
  end

  def render_400
    render json: {
      error: "Bad request",
      status: 400
    }, status: 400
  end

  def breed_database
    [['Affenpinscher', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Afghan Hound', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Airedale Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Akita', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Alaskan Malamute', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'low'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['American Eskimo Dog', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['American Staffordshire Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['American Water Spaniel', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Anatolian Shepherd', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Australian Shepherd', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'medium'], ['agility', 'high']]], ['Australian Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Basenji', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'high']]], ['Basset Hound', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'high'], ['size', 'medium'], ['agility', 'low']]], ['Beagle', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Bearded Collie', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'low'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'high']]], ['Beauceron', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Bedlington Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Bernese Mountain Dog', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Bichon Frise', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Black and Tan Coonhound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Black Russian Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Bloodhound', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Border Collie', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'high']]], ['Border Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Borzoi', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Boston Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Boxer', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Briard', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Brussels Griffon', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Bullmastiff', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Bull Terrier', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Cairn Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Canaan Dog', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'high']]], ['Cavalier King Charles Spaniel', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Chesapeake Bay Retriever', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Chihuahua', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Chow Chow', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'high'], ['guard', 'high'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Clumber Spaniel', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Cocker Spaniel', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Collie', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'high'], ['agility', 'high']]], ['Curly-Coated Retriever', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Dachshund', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'low']]], ['Dalmatian', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Doberman Pinscher', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'high'], ['size', 'high'], ['agility', 'high']]], ['Dogue de Bordeaux', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'low']]], ['English Cocker Spaniel', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['English Setter', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['English Springer Spaniel', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'high'], ['size', 'medium'], ['agility', 'medium']]], ['English Toy Spaniel', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Field Spaniel', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Finnish Spitz', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['French Bulldog', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['German Pinscher', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'high'], ['guard', 'high'], ['popular', 'low'], ['size', 'medium'], ['agility', 'high']]], ['German Shorthaired Pointer', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['German Wirehaired Pointer', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Giant Schnauzer', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Glen of Imaal Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Golden Retriever', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Gordon Setter', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Great Dane', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Greater Swiss Mountain Dog', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Great Pyrenees', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'high'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Greyhound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'high']]], ['Harrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Havanese', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Ibizan Hound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'high']]], ['Irish Setter', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Irish Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Irish Water Spaniel', [['train', 'high'], ['shed', 'low'], ['iq', 'high'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Irish Wolfhound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Italian Greyhound', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'high']]], ['Jack Russell Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'low'], ['agility', 'low']]], ['Japanese Chin', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Keeshond', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Kerry Blue Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Komondor', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Kuvasz', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Labrador Retriever', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Lakeland Terrier', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Lhasa Apso', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Lowchen', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Maltese', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Manchester Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Mastiff', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'low'], ['guard', 'high'], ['popular', 'high'], ['size', 'high'], ['agility', 'low']]], ['Miniature Pinscher', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'high']]], ['Neapolitan Mastiff', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'low']]], ['Norfolk Terrier', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Norwegian Elkhound', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Norwich Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Old English Sheepdog', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'low'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'high']]], ['Otterhound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Papillon', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'high'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Pekingese', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'low']]], ['Petit Basset Griffon Vendeen', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Pharaoh Hound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'high']]], ['Pointer', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Polish Lowland Sheepdog', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'low'], ['size', 'medium'], ['agility', 'high']]], ['Pomeranian', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Poodle', [['train', 'high'], ['shed', 'low'], ['iq', 'high'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'high'], ['size', 'medium'], ['agility', 'high']]], ['Portuguese Water Dog', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Pug', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'low'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Puli', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Rhodesian Ridgeback', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'high'], ['agility', 'medium']]], ['Rottweiler', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'high'], ['guard', 'high'], ['popular', 'high'], ['size', 'high'], ['agility', 'medium']]], ['Saluki', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'high'], ['agility', 'high']]], ['Samoyed', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Schipperke', [['train', 'high'], ['shed', 'high'], ['iq', 'high'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Scottish Deerhound', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'medium'], ['popular', 'low'], ['size', 'high'], ['agility', 'high']]], ['Sealyham Terrier', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'medium']]], ['Shiba In', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Shih Tz', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'high'], ['guard', 'low'], ['popular', 'high'], ['size', 'low'], ['agility', 'medium']]], ['Siberian Husky', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'high'], ['popular', 'high'], ['size', 'medium'], ['agility', 'high']]], ['Silky Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Skye Terrier', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'low'], ['agility', 'low']]], ['Smooth Fox Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Staffordshire Bull Terrier', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Schnauzer', [['train', 'high'], ['shed', 'low'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Sussex Spaniel', [['train', 'low'], ['shed', 'medium'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'low'], ['size', 'medium'], ['agility', 'medium']]], ['Swedish Vallhund', [['train', 'medium'], ['shed', 'high'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'medium']]], ['Tibetan Mastiff', [['train', 'low'], ['shed', 'high'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'high'], ['popular', 'low'], ['size', 'high'], ['agility', 'medium']]], ['Tibetan Spaniel', [['train', 'medium'], ['shed', 'medium'], ['iq', 'medium'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Tibetan Terrier', [['train', 'low'], ['shed', 'low'], ['iq', 'low'], ['watch', 'medium'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Toy Fox Terrier', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'high'], ['guard', 'medium'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Vizsla', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'medium'], ['agility', 'high']]], ['Weimaraner', [['train', 'high'], ['shed', 'medium'], ['iq', 'high'], ['watch', 'medium'], ['guard', 'medium'], ['popular', 'high'], ['size', 'medium'], ['agility', 'high']]], ['Welsh Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]], ['Whippet', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'low'], ['guard', 'low'], ['popular', 'medium'], ['size', 'medium'], ['agility', 'high']]], ['Wire Fox Terrier', [['train', 'medium'], ['shed', 'low'], ['iq', 'medium'], ['watch', 'high'], ['guard', 'low'], ['popular', 'medium'], ['size', 'low'], ['agility', 'medium']]]]
  end
end

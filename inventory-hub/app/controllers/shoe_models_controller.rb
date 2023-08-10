# @tag ShoeModelsController
# API for availability of a specific shoe model.
class ShoeModelsController < ApplicationController
  # Returns a shoe model and all of its available inventory
  #
  # @response_status 200
  # @response_class ShoeModelSerializer
  def show
    @shoe_model = ShoeModel.find(params[:id])

    respond_to do |format|
      format.html { render :show, status: :ok }
      format.json { render json: @shoe_model, status: :ok }
    end    
  end


  def suggestion
    query = params[:query]

    @result = {:valid => false}
    return if query.blank?
    
    # puts build_suggestion_body_from query
    @resp = Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
      req.headers['Authorization'] = "Bearer #{ENV.fetch('OPENAPI_TOKEN')}"
      req.headers['Content-Type'] = 'application/json'

      req.body = build_suggestion_body_from query
    end

    response = JSON.parse @resp.body

    puts ''
    puts '--- OPENAPI RESPONSE ---'
    puts response
    puts ''
    puts ''

    suggestion = JSON.parse response['choices'][0]['message']['content']

    @result = {
      :valid => true,
      :shoe_name => suggestion['shoe'],
      :motive => suggestion['motive'],
      :description => suggestion['description'],
    }
  end

  private

  def build_suggestion_body_from(query)
    return {
      "model": "gpt-3.5-turbo",
      "messages": [
          {
              "role": "user",
              "content": OPENAPI_PROMPT_1
          },
          {
              "role": "user",
              "content": OPENAPI_PROMPT_2
          },
          {
              "role": "user",
              "content": "My first request is '#{query}'. The JSON response:"
          }
      ],
      "temperature": 0.8,
      "top_p": 1,
      "n": 1,
      "stream": false,
      "max_tokens": 3000,
      "presence_penalty": 0,
      "frequency_penalty": 0
    }.to_json
  end

  OPENAPI_PROMPT_1 = %(
    1. Casual Lifestyle Sneakers:
    Step into comfort and style with our casual lifestyle sneakers. These versatile shoes are designed to enhance your everyday look while ensuring all-day comfort. The sleek and modern design effortlessly pairs with your casual attire, making them perfect for outings, social gatherings, or simply strolling around town. The cushioned insoles provide excellent support, while the breathable upper material keeps your feet feeling fresh. Whether you're exploring the city streets or meeting up with friends, these casual lifestyle sneakers are your go-to choice for a fashionable and relaxed vibe.
    
    2. High-Performance Running Shoes:
    Experience the thrill of running with our high-performance running shoes. Crafted with advanced technology, these shoes are engineered to optimize your running experience. The lightweight design and responsive cushioning propel you forward, while the breathable mesh upper ensures proper ventilation during intense workouts. The durable outsole offers excellent traction on various terrains, making these shoes suitable for road or trail running. Push your limits and achieve new personal bests while enjoying the comfort and support these running shoes provide.
    
    3. Trekking Adventure Boots:
    Embark on your next trekking adventure with confidence, wearing our rugged trekking boots. Designed to conquer challenging terrains, these boots offer exceptional durability and stability. The waterproof construction keeps your feet dry in wet conditions, while the reinforced toe and heel provide added protection. The multidirectional lugs on the outsole ensure optimal grip on uneven surfaces, giving you the traction needed to conquer steep trails. Whether you're hiking through forests or traversing rocky paths, these trekking boots are your reliable companion for outdoor exploration.
    
    4. Urban Trail Running Shoes:
    Combine urban style with trail-ready performance in our urban trail running shoes. Perfect for those who enjoy both city streets and off-road adventures, these shoes feature a versatile design with rugged capabilities. The responsive midsole cushions your stride during urban jogs, while the aggressive outsole tread offers stability on unpaved paths. The lightweight construction and flexible materials allow for agile movements, whether you're navigating through city obstacles or tackling uneven trails. Elevate your running experience with these dynamic urban trail shoes that seamlessly transition between environments.
    
    5. Casual Canvas Sneakers:
    Elevate your casual wardrobe with our comfortable canvas sneakers. These classic shoes blend timeless style with everyday comfort, making them a staple for your laid-back outings. The canvas upper provides a relaxed and breathable fit, while the rubber outsole ensures steady traction on various surfaces. Whether you're running errands, meeting friends, or taking a leisurely stroll, these casual canvas sneakers effortlessly complement your relaxed attire while keeping your feet at ease.
    
    6. Technical Rock Climbing Shoes:
    Conquer the most challenging rock faces with our technical rock climbing shoes. Engineered for precision and grip, these shoes offer a snug fit that enhances your climbing performance. The downturned shape and sticky rubber outsole provide maximum contact and friction, allowing you to confidently grip footholds and edges. The specialized design allows for precise foot placements and sensitivity, enabling you to tackle intricate routes with finesse. Whether you're bouldering or tackling multi-pitch climbs, these technical rock climbing shoes are your essential gear for pushing your climbing boundaries.
    
    7. All-Terrain Trail Running Shoes:
    Unleash your adventurous spirit with our all-terrain trail running shoes. These versatile shoes are built to handle a variety of landscapes, from rocky trails to muddy paths. The reinforced toe and durable materials offer protection against trail debris, while the cushioned midsole absorbs shock and provides comfort on rugged terrains. The aggressive outsole tread ensures optimal traction, whether you're ascending steep inclines or descending slippery slopes. Embrace the thrill of off-road running and explore the great outdoors with the confidence that these all-terrain trail running shoes provide.
    
    8. Lightweight Hiking Shoes:
    Experience the perfect blend of comfort and support with our lightweight hiking shoes. Designed for hikers who value agility and mobility, these shoes feature a streamlined design that allows for nimble movements on the trail. The breathable mesh upper keeps your feet cool during long hikes, while the cushioned insole and EVA midsole offer superior comfort and shock absorption. The rugged outsole provides reliable traction on various terrains, making these lightweight hiking shoes ideal for day hikes and extended treks alike. Embrace the joy of hiking with footwear that prioritizes both performance and comfort.
  )

  OPENAPI_PROMPT_2 = %(
    Do not include any explanations, only provide a RFC8259 compliant JSON response following this format without deviation.
    {
      "id": "the number of the recommended shoe from the list of 8 options",
      "shoe": "the name of the recommended shoe from the list of 8 options",
      "description": "the full description of the recommended shoe from the list of 8 options",
      "motive": "a 2 sentences explaining why this shoe was chosen as the recommended shoe",
    }
  )
    
end

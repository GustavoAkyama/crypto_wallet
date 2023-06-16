require 'httparty'

class WelcomeController < ApplicationController
  def index

    api_key = API_KEYS['api_key']

    if I18n.locale.to_s == "pt-BR"
      lang = "pt"
    else
      lang = "en"
    end

    url = "https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=#{api_key}"
    url = "https://newsapi.org/v2/everything?q=cryptocurrency&language=#{lang}&apiKey=#{api_key}"
    response = HTTParty.get(url)
    
    @news = response.parsed_response['articles'].first(3)

  end
end

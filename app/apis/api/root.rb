require 'grape'
module API
  class Root < Grape::API
    prefix 'api/'
    mount API::Ver1::PokerApi


    get do


    end
  end
end

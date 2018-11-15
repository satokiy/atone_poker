class HomeController < ApplicationController
  def top
  end

  def check
    @cards = params[:cards]

    a = @cards.split(/\s*/)


  end


end

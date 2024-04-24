class HomeController < ApplicationController
  def index
    @participants = current_psychologist.participants
  end
end

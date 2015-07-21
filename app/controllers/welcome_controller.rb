class WelcomeController < ApplicationController
  def index
    @duser_size = Duser.all().size()
    @duser_last = Duser.last
  end
end
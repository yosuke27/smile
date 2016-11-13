class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to '/calender/weekly'
    end
  end

  def help
  end

  def about
  end
end

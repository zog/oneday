class DaysController < ApplicationController
  find_by_key :permalink

  def index
  end

  def new
    @day = Day.where(user_id: current_user.id).where(country: nil).last
    unless @day
      @day = Day.create
      @day.user = current_user
      @day.save validate: false
    end
    redirect_to [:edit, @day]
  end

  def create
    save_resource
    redirect_to [:add_moments, resource]
  end

  def resource_params
    params.require(:day).permit!
  end

end

class MomentsController < ApplicationController
  before_filter :load_day

  def controller_namespace
    [@day]
  end

  def resource_params
    params.require(:moment).permit!
  end

  def show
    redirect_to [resource.day]
  end

  def create
    build_resource
    resource.day = @day
    resource.save!
    success_response
  end

  def load_day
    @day = Day.where(permalink: params[:day_id]).last
  end
end

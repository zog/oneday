require 'active_support/concern'

module DeviseExtensions
  extend ActiveSupport::Concern

  def after_sign_in_path_for(resource)
    return params[:redirect] if params[:redirect]
    [:new, :day]
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for resource
  end
end

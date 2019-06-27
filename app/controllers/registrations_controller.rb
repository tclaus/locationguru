# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end

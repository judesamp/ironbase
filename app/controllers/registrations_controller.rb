class RegistrationsController < Devise::RegistrationsController
  after_filter :process_admin 

  protected

  def process_admin
    if resource.persisted? # user is created successfuly
      #puts params: password not filtered here; okay?
      unless params[:admin].nil?
        resource.add_role :admin
      end
    end
 end
end
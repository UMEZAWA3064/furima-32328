class ApplicationController < ActionController::Base

  
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  def configure_permitted_parameters        #データベースに保存できるように設定
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :encrypted_password, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date])
  end
end

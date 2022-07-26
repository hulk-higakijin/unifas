module Professorable
  extend ActiveSupport::Concern

  def set_professor
    @professor = current_account.professor
  end

  def authenticate_professor!(redirect_path)
    redirect_to redirect_path unless current_account.professor?
  end
end

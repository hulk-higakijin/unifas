module Professorable
  extend ActiveSupport::Concern

  def set_professor
    @professor = current_account.professor
  end
end

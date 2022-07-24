class RecruitmentsController < ApplicationController
  before_action -> { authenticate_account! && authenticate_professor! }, only: %i[new edit create update]
  before_action :set_recruitment

  def index; end

  def show; end

  def new
    @universities = University.active ## professor_universtiesを参照して、教授の大学のみを選択可能にする
    @university = University.find_by(id: params[:university_id])
  end

  def edit
    @universities = University.active ## 同上
    @university = @recruitment.university
  end

  def create
    if @recruitment.save
      redirect_to recruitment_path(@recruitment)
    else
      @universities = University.active ## 同上
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recruitment.update(recruitment_params)
      redirect_to recruitment_url(@recruitment)
    else
      @universities = University.active ## 同上
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recruitment.destroy
    redirect_to recruitments_url, notice: 'Recruitment was successfully destroyed.'
  end

  private

    def set_recruitment
      case action_name
      when 'index'
        @recruitments = Recruitment.eager_load([faculty: :university])
      when 'show'
        @recruitment = Recruitment.find(params[:id])
      when 'new'
        @recruitment = Recruitment.new
      when 'create'
        @recruitment = current_account.professor.recruitments.new(recruitment_params)
      when 'edit', 'update', 'destroy'
        @recruitment = current_account.professor.recruitments.find(params[:id])
      end
    end

    def authenticate_professor!
      redirect_to recruitments_path unless current_account.professor?
    end

    def recruitment_params
      params.require(:recruitment).permit(:title, :body, :faculty_id)
    end
end

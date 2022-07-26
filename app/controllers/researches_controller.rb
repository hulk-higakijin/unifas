class ResearchesController < ApplicationController
  include Professorable

  before_action -> { authenticate_account! && authenticate_professor!(researches_path) }, only: %i[new edit create update]
  before_action :set_professor, only: %i[create edit update destroy]
  before_action :set_research

  def index; end

  def show; end

  def new
    @universities = University.active ## 同上
    @university = University.find_by(id: params[:university_id])
  end

  def edit
    @universities = University.active ## 同上
    @university = @research.university
  end

  def create
    if @research.save
      redirect_to research_url(@research)
    else
      @universities = University.active ## 同上
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @research.update(research_params)
      redirect_to research_url(@research), notice: 'Research was successfully updated.'
    else
      @universities = University.active ## 同上
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @research.destroy
    redirect_to researches_url, notice: 'Research was successfully destroyed.'
  end

  private

    def set_research
      case action_name
      when 'index' then @researches = Research.eager_load([faculty: :university], :professor)
      when 'show' then @research = Research.find(params[:id])
      when 'new' then @research = Research.new
      when 'create' then @research = @professor.researches.new(research_params)
      when 'edit', 'update', 'destroy' then @research = @professor.researches.find(params[:id])
      end
    end

    def research_params
      params.require(:research).permit(:title, :body, :faculty_id)
    end
end

class ResearchesController < ApplicationController
  include Professorable

  before_action -> { authenticate_account! && authenticate_professor!(researches_path) }, only: %i[new edit create update]
  before_action :set_research, only: %i[show]
  before_action :set_professor, only: %i[create edit update destroy]

  def index
    @researches = Research.eager_load([faculty: :university], :professor)
  end

  def show; end

  def new
    @research = Research.new
    @universities = University.active ## 同上
    @university = University.find_by(id: params[:university_id])
  end

  def edit
    @research = @professor.researches.find(params[:id])
    @universities = University.active ## 同上
    @university = @research.university
  end

  def create
    @research = @professor.researches.new(research_params)

    if @research.save
      redirect_to research_url(@research)
    else
      @universities = University.active ## 同上
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @research = @professor.researches.find(params[:id])
    if @research.update(research_params)
      redirect_to research_url(@research), notice: 'Research was successfully updated.'
    else
      @universities = University.active ## 同上
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @research = @professor.researches.find(params[:id])
    @research.destroy
    redirect_to researches_url, notice: 'Research was successfully destroyed.'
  end

  private

    def set_research
      @research = Research.find(params[:id])
    end

    def research_params
      params.require(:research).permit(:title, :body, :faculty_id)
    end
end

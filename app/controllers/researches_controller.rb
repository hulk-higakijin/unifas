class ResearchesController < ApplicationController
  include Professorable

  before_action :set_research, only: %i[show edit update destroy]
  before_action :set_professor, only: %i[create edit]

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
    @universities = University.active ## 同上
    @university = @research.university
  end

  def create
    @research = @professor.researches.new(research_params)

    if @research.save
      redirect_to research_url(@research)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @research.update(research_params)
      redirect_to research_url(@research), notice: 'Research was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

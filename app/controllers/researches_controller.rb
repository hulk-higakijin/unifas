class ResearchesController < ApplicationController
  before_action :set_research, only: %i[show edit update destroy]

  def index
    @researches = Research.eager_load([faculty: :university], :professor)
  end

  def show; end

  def new
    @research = Research.new
  end

  def edit; end

  def create
    @research = Research.new(research_params)

    respond_to do |format|
      if @research.save
        format.html { redirect_to research_url(@research), notice: 'Research was successfully created.' }
        format.json { render :show, status: :created, location: @research }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @research.update(research_params)
        format.html { redirect_to research_url(@research), notice: 'Research was successfully updated.' }
        format.json { render :show, status: :ok, location: @research }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @research.destroy

    respond_to do |format|
      format.html { redirect_to researches_url, notice: 'Research was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_research
      @research = Research.find(params[:id])
    end

    def research_params
      params.require(:research).permit(:title, :body, :professor_id, :faculty_id)
    end
end

class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: %i[show edit update destroy]

  # GET /recruitments or /recruitments.json
  def index
    @recruitments = Recruitment.all
  end

  # GET /recruitments/1 or /recruitments/1.json
  def show; end

  # GET /recruitments/new
  def new
    @recruitment = Recruitment.new
  end

  # GET /recruitments/1/edit
  def edit; end

  # POST /recruitments or /recruitments.json
  def create
    @recruitment = Recruitment.new(recruitment_params)

    respond_to do |format|
      if @recruitment.save
        format.html { redirect_to recruitment_url(@recruitment), notice: 'Recruitment was successfully created.' }
        format.json { render :show, status: :created, location: @recruitment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruitments/1 or /recruitments/1.json
  def update
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        format.html { redirect_to recruitment_url(@recruitment), notice: 'Recruitment was successfully updated.' }
        format.json { render :show, status: :ok, location: @recruitment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruitments/1 or /recruitments/1.json
  def destroy
    @recruitment.destroy

    respond_to do |format|
      format.html { redirect_to recruitments_url, notice: 'Recruitment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_recruitment
      @recruitment = Recruitment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recruitment_params
      params.require(:recruitment).permit(:title, :body, :professor_id, :faculty_id)
    end
end

class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: %i[show edit update destroy]
  before_action :set_professor, only: %i[new]

  # GET /recruitments or /recruitments.json
  def index
    @recruitments = Recruitment.all
  end

  # GET /recruitments/1 or /recruitments/1.json
  def show; end

  # GET /recruitments/new
  def new
    @recruitment = Recruitment.new
    @universities = University.active ## professor_universtiesを参照して、教授の大学のみを選択可能にする
    @university = University.find_by(id: params[:university_id])
  end

  # GET /recruitments/1/edit
  def edit
    @universities = University.active
    @university = @recruitment.faculty.university
  end

  # POST /recruitments or /recruitments.json
  def create
    @recruitment = @professor.recruitments.new(recruitment_params)

    if @recruitment.save
      redirect_to recruitment_path(@recruitment)
    else
      render :new, status: :unprocessable_entity
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

    def set_professor
      @professor = current_account.professor
    end

    # Only allow a list of trusted parameters through.
    def recruitment_params
      params.require(:recruitment).permit(:title, :body, :faculty_id)
    end
end

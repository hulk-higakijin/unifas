class RecruitmentsController < ApplicationController
  before_action :authenticate_account!, only: %i[new]
  before_action :authenticate_professor!, only: %i[new]
  before_action :set_recruitment, only: %i[show edit update destroy]
  before_action :set_professor, only: %i[create update]

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
    if @recruitment.update(recruitment_params)
      redirect_to recruitment_url(@recruitment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recruitments/1 or /recruitments/1.json
  def destroy
    @recruitment.destroy
    redirect_to recruitments_url, notice: 'Recruitment was successfully destroyed.'
  end

  private

    def authenticate_professor!
      redirect_to root_path unless current_account.professor?
    end

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

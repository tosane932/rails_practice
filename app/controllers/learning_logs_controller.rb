class LearningLogsController < ApplicationController
  before_action :set_learning_log, only: %i[ show edit update destroy ]

  # GET /learning_logs or /learning_logs.json
  def index
    @learning_logs = LearningLog.all
  end

  # GET /learning_logs/1 or /learning_logs/1.json
  def show
  end

  # GET /learning_logs/new
  def new
    @learning_log = LearningLog.new
  end

  # GET /learning_logs/1/edit
  def edit
  end

# POST /learning_logs or /learning_logs.json
  def create
    @learning_log = LearningLog.new(learning_log_params)

    respond_to do |format|
      if @learning_log.save
        format.html { redirect_to learning_log_url(@learning_log), notice: "Learning log was successfully created." }
        # ⚡ JS（Fetch API）には、作成したデータ＋全体の最新ステータスをJSONで返す
        format.json { 
          render json: { 
            status: "success", 
            log: @learning_log,
            total_days: LearningLog.total_days,
            total_hours: LearningLog.total_hours,
            current_level: LearningLog.current_level
          }, status: :created 
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @learning_log.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /learning_logs/1 or /learning_logs/1.json
  def update
    respond_to do |format|
      if @learning_log.update(learning_log_params)
        format.html { redirect_to @learning_log, notice: "Learning log was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @learning_log }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @learning_log.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /learning_logs/1 or /learning_logs/1.json
  def destroy
    @learning_log.destroy!

    respond_to do |format|
      format.html { redirect_to learning_logs_path, notice: "Learning log was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_log
      @learning_log = LearningLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def learning_log_params
      params.expect(learning_log: [ :learned_on, :duration_mins, :memo ])
    end
end

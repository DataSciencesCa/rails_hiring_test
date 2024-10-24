class RidingsController < ApplicationController
  before_action :set_riding, only: %i[ show edit update destroy edit_polling_locations add_new_polling_location ]
  before_action :set_polls, only: %i[ edit_polling_locations add_new_polling_location ]

  # GET /ridings or /ridings.json
  def index
    @ridings = Riding.all
  end

  # GET /ridings/1 or /ridings/1.json
  def show
    @polling_locations = @riding.polling_locations
  end

  # GET /ridings/new
  def new
    @riding = Riding.new
  end

  # GET /ridings/1/edit
  def edit
  end

  def edit_polling_locations
    @polling_locations = @riding.polling_locations
  end

  # POST /ridings or /ridings.json
  def create
    @riding = Riding.new(riding_params)

    respond_to do |format|
      if @riding.save
        format.html { redirect_to riding_url(@riding), notice: "Riding was successfully created." }
        format.json { render :show, status: :created, location: @riding }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @riding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ridings/1 or /ridings/1.json
  def update
    respond_to do |format|
      if @riding.update(riding_params)
        #update_polls
        format.html { redirect_to riding_url(@riding), notice: "Riding was successfully updated." }
        format.json { render :show, status: :ok, location: @riding }
      else
        format.turbo_stream
        format.json { render json: @riding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ridings/1 or /ridings/1.json
  def destroy
    @riding.destroy!

    respond_to do |format|
      format.html { redirect_to ridings_url, notice: "Riding was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_riding
      @riding = Riding.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def riding_params
      params.require(:riding).permit(:name, :riding_code, :province,
                                     polling_locations_attributes: [:id, :title, :address, :city, :postal_code,
                                      :_destroy, poll_ids: [] ])
    end

    def set_polls
      @polls = @riding.polls.sort_by{ |poll| poll.number.to_i }
      @available_polls = @polls.select{ |poll| poll.polling_location_id.nil? }
    end
end

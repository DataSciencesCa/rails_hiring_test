class PollingLocationsController < ApplicationController
    before_action :set_polling_location, only: %i[ show edit update destroy ]
    include ActionView::RecordIdentifier

    # GET /ridings or /ridings.json
    # def index
    #   @ridings = Riding.all
    # end
  
    # GET /ridings/1 or /ridings/1.json
    def show
    end
  
    # GET /polling_locations/new
    def new
      @polling_location = PollingLocation.new
    end
  
    # GET /ridings/1/edit
    def edit
    end
  
    # POST /ridings or /ridings.json
    def create
      @riding = Riding.find(params[:riding_id])
      @polling_location = @riding.polling_locations.new(polling_location_params)
  
      respond_to do |format|
        if @polling_location.save
          format.html { redirect_to riding_url(@riding), notice: "Polling Location was successfully created." }
          format.json { render :show, status: :created, location: @polling_location }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @polling_location.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /ridings/1 or /ridings/1.json
    def update
      respond_to do |format|
        if @polling_location.update(polling_location_params)
            format.html { redirect_to riding_url(@riding), notice: "Polling Location was successfully updated." }
            format.json { render :show, status: :ok, location: @polling_location }
            format.turbo_stream do
                render turbo_stream: [
                    turbo_stream.replace(dom_id(@polling_location, :title), partial: "polling_locations/title", locals: { riding: @riding, polling_location: @polling_location }),
                    turbo_stream.replace(dom_id(@polling_location, :address), partial: "polling_locations/address", locals: { riding: @riding, polling_location: @polling_location }),
                    turbo_stream.replace(dom_id(@polling_location, :city), partial: "polling_locations/city", locals: { riding: @riding, polling_location: @polling_location }),
                    turbo_stream.replace(dom_id(@polling_location, :postal_code), partial: "polling_locations/postal_code", locals: { riding: @riding, polling_location: @polling_location })
                ]
            end
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @polling_location.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /ridings/1 or /ridings/1.json
    def destroy
      @polling_location.destroy!
  
      respond_to do |format|
        format.html { redirect_to ridings_url, notice: "Polling Location was successfully deleted." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_polling_location
        @riding = Riding.find(params[:riding_id])
        @polling_location = @riding.polling_locations.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def polling_location_params
        params.require(:polling_location).permit(:title, :address, :city, :postal_code)
      end
  end
  
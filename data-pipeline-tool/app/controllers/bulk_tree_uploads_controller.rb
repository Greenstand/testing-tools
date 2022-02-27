class BulkTreeUploadsController < ApplicationController
  before_action :set_bulk_tree_upload, only: %i[ show edit update destroy ]

  # GET /bulk_tree_uploads or /bulk_tree_uploads.json
  def index
    @bulk_tree_uploads = BulkTreeUpload.paginate(:page => params[:page], :per_page=>25).order(created_at: :desc)
  end

  # GET /bulk_tree_uploads/1 or /bulk_tree_uploads/1.json
  def show
  end

  # GET /bulk_tree_uploads/new
  def new
    @bulk_tree_upload = BulkTreeUpload.new
  end

  # GET /bulk_tree_uploads/1/edit
  def edit
  end

  # POST /bulk_tree_uploads or /bulk_tree_uploads.json
  def create
    @bulk_tree_upload = BulkTreeUpload.new(bulk_tree_upload_params)

    respond_to do |format|
      if @bulk_tree_upload.save
        format.html { redirect_to bulk_tree_upload_url(@bulk_tree_upload), notice: "Bulk tree upload was successfully created." }
        format.json { render :show, status: :created, location: @bulk_tree_upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bulk_tree_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulk_tree_uploads/1 or /bulk_tree_uploads/1.json
  def update
    respond_to do |format|
      if @bulk_tree_upload.update(bulk_tree_upload_params)
        format.html { redirect_to bulk_tree_upload_url(@bulk_tree_upload), notice: "Bulk tree upload was successfully updated." }
        format.json { render :show, status: :ok, location: @bulk_tree_upload }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bulk_tree_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulk_tree_uploads/1 or /bulk_tree_uploads/1.json
  def destroy
    @bulk_tree_upload.destroy

    respond_to do |format|
      format.html { redirect_to bulk_tree_uploads_url, notice: "Bulk tree upload was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulk_tree_upload
      @bulk_tree_upload = BulkTreeUpload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bulk_tree_upload_params
      params.require(:bulk_tree_upload).permit(:key, :processed)
    end
end

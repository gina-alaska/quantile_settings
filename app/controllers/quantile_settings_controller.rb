class QuantileSettingsController < ApplicationController
  # GET /quantile_settings
  # GET /quantile_settings.json
  def index
    @quantile_settings = QuantileSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quantile_settings }
    end
  end

  # GET /quantile_settings/1
  # GET /quantile_settings/1.json
  def show
    @quantile_setting = QuantileSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quantile_setting }
    end
  end

  # GET /quantile_settings/new
  # GET /quantile_settings/new.json
  def new
    @quantile_setting = QuantileSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quantile_setting }
    end
  end

  # GET /quantile_settings/1/edit
  def edit
    @quantile_setting = QuantileSetting.find(params[:id])
  end
  
  # POST /quantile_settings/1/run
  def run
    @quantile_setting = QuantileSetting.find(params[:id])
    
    respond_to do |format|
      if @quantile_setting.queue
        format.html { redirect_to @quantile_setting, notice: 'Quantile setting was successfully queued.' }
      end
    end    
  end

  # POST /quantile_settings
  # POST /quantile_settings.json
  def create
    @quantile_setting = QuantileSetting.new(params[:quantile_setting])

    respond_to do |format|
      if @quantile_setting.save
        format.html { redirect_to quantile_settings_path, notice: 'Quantile setting was successfully created.' }
        format.json { render json: @quantile_setting, status: :created, location: @quantile_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @quantile_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quantile_settings/1
  # PUT /quantile_settings/1.json
  def update
    @quantile_setting = QuantileSetting.find(params[:id])

    respond_to do |format|
      if @quantile_setting.update_attributes(params[:quantile_setting])
        format.html { redirect_to quantile_settings_path, notice: 'Quantile setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quantile_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantile_settings/1
  # DELETE /quantile_settings/1.json
  def destroy
    @quantile_setting = QuantileSetting.find(params[:id])
    @quantile_setting.destroy

    respond_to do |format|
      format.html { redirect_to quantile_settings_url }
      format.json { head :no_content }
    end
  end
end

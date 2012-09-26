class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  before_filter :fetch_quantile_setting
  
  def index
    @reports = @quantile_setting.reports.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = @quantile_setting.reports.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end
  
  # POST /quantile_settings/1/run
  def run
    @report = @quantile_setting.reports.find(params[:id])
    
    respond_to do |format|
      if @report.queue
        format.html { redirect_to [@quantile_setting, @report], notice: 'Quantile setting was successfully queued.' }
      end
    end    
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = @quantile_setting.reports.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = @quantile_setting.reports.find(params[:id])
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = @quantile_setting.reports.new(params[:report])

    respond_to do |format|
      if @report.save
        format.html { redirect_to [@quantile_setting, @report], notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = @quantile_setting.reports.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to [@quantile_setting, @report], notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = @quantile_setting.reports.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to quantile_setting_reports_url(@quantile_setting) }
      format.json { head :no_content }
    end
  end
  
  protected
  
  def fetch_quantile_setting
    @quantile_setting = QuantileSetting.find(params[:quantile_setting_id])
  end
end

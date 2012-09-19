class QuantilePeriodsController < ApplicationController
  # GET /quantile_periods
  # GET /quantile_periods.json
  def index
    @quantile_periods = QuantilePeriod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quantile_periods }
    end
  end

  # GET /quantile_periods/1
  # GET /quantile_periods/1.json
  def show
    @quantile_period = QuantilePeriod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quantile_period }
    end
  end

  # GET /quantile_periods/new
  # GET /quantile_periods/new.json
  def new
    @quantile_period = QuantilePeriod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quantile_period }
    end
  end

  # GET /quantile_periods/1/edit
  def edit
    @quantile_period = QuantilePeriod.find(params[:id])
  end

  # POST /quantile_periods
  # POST /quantile_periods.json
  def create
    @quantile_period = QuantilePeriod.new(params[:quantile_period])

    respond_to do |format|
      if @quantile_period.save
        format.html { redirect_to @quantile_period, notice: 'Quantile period was successfully created.' }
        format.json { render json: @quantile_period, status: :created, location: @quantile_period }
      else
        format.html { render action: "new" }
        format.json { render json: @quantile_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quantile_periods/1
  # PUT /quantile_periods/1.json
  def update
    @quantile_period = QuantilePeriod.find(params[:id])

    respond_to do |format|
      if @quantile_period.update_attributes(params[:quantile_period])
        format.html { redirect_to @quantile_period, notice: 'Quantile period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quantile_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantile_periods/1
  # DELETE /quantile_periods/1.json
  def destroy
    @quantile_period = QuantilePeriod.find(params[:id])
    @quantile_period.destroy

    respond_to do |format|
      format.html { redirect_to quantile_periods_url }
      format.json { head :no_content }
    end
  end
end

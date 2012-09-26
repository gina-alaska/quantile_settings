require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post :create, report: { adjusted: @report.adjusted, high_temp_threshold: @report.high_temp_threshold, historical: @report.historical, low_temp_threshold: @report.low_temp_threshold, observed: @report.observed, predicted: @report.predicted, quantile_settings_id: @report.quantile_settings_id }
    end

    assert_redirected_to report_path(assigns(:report))
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report
    assert_response :success
  end

  test "should update report" do
    put :update, id: @report, report: { adjusted: @report.adjusted, high_temp_threshold: @report.high_temp_threshold, historical: @report.historical, low_temp_threshold: @report.low_temp_threshold, observed: @report.observed, predicted: @report.predicted, quantile_settings_id: @report.quantile_settings_id }
    assert_redirected_to report_path(assigns(:report))
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_redirected_to reports_path
  end
end

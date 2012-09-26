require 'test_helper'

class QuantileSettingsControllerTest < ActionController::TestCase
  setup do
    @quantile_setting = quantile_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quantile_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quantile_setting" do
    assert_difference('QuantileSetting.count') do
      post :create, quantile_setting: { algorithm: @quantile_setting.algorithm, historical_start: @quantile_setting.historical_start, historical_end: @quantile_setting.historical_end, period_id: @quantile_setting.period_id, predicted_end: @quantile_setting.predicted_end, predicted_start: @quantile_setting.predicted_start }
    end

    assert_redirected_to quantile_setting_path(assigns(:quantile_setting))
  end

  test "should show quantile_setting" do
    get :show, id: @quantile_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quantile_setting
    assert_response :success
  end

  test "should update quantile_setting" do
    put :update, id: @quantile_setting, quantile_setting: { algorithm: @quantile_setting.algorithm, historical_start: @quantile_setting.historical_start, historical_end: @quantile_setting.historical_end, period_id: @quantile_setting.period_id, predicted_end: @quantile_setting.predicted_end, predicted_start: @quantile_setting.predicted_start }
    assert_redirected_to quantile_setting_path(assigns(:quantile_setting))
  end

  test "should destroy quantile_setting" do
    assert_difference('QuantileSetting.count', -1) do
      delete :destroy, id: @quantile_setting
    end

    assert_redirected_to quantile_settings_path
  end
end

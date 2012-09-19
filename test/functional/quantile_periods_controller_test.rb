require 'test_helper'

class QuantilePeriodsControllerTest < ActionController::TestCase
  setup do
    @quantile_period = quantile_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quantile_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quantile_period" do
    assert_difference('QuantilePeriod.count') do
      post :create, quantile_period: { name: @quantile_period.name }
    end

    assert_redirected_to quantile_period_path(assigns(:quantile_period))
  end

  test "should show quantile_period" do
    get :show, id: @quantile_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quantile_period
    assert_response :success
  end

  test "should update quantile_period" do
    put :update, id: @quantile_period, quantile_period: { name: @quantile_period.name }
    assert_redirected_to quantile_period_path(assigns(:quantile_period))
  end

  test "should destroy quantile_period" do
    assert_difference('QuantilePeriod.count', -1) do
      delete :destroy, id: @quantile_period
    end

    assert_redirected_to quantile_periods_path
  end
end

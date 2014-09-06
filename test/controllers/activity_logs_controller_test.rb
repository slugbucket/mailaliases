require 'test_helper'

class ActivityLogsControllerTest < ActionController::TestCase
  setup do
    @activity_log = activity_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activity_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activity_log" do
    assert_difference('ActivityLog.count') do
      post :create, activity_log: { act_action: @activity_log.act_action, act_tstamp: @activity_log.act_tstamp, activity: @activity_log.activity, item_id: @activity_log.item_id, item_type: @activity_log.item_type, updated_by: @activity_log.updated_by }
    end

    assert_redirected_to activity_log_path(assigns(:activity_log))
  end

  test "should show activity_log" do
    get :show, id: @activity_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activity_log
    assert_response :success
  end

  test "should update activity_log" do
    patch :update, id: @activity_log, activity_log: { act_action: @activity_log.act_action, act_tstamp: @activity_log.act_tstamp, activity: @activity_log.activity, item_id: @activity_log.item_id, item_type: @activity_log.item_type, updated_by: @activity_log.updated_by }
    assert_redirected_to activity_log_path(assigns(:activity_log))
  end

  test "should destroy activity_log" do
    assert_difference('ActivityLog.count', -1) do
      delete :destroy, id: @activity_log
    end

    assert_redirected_to activity_logs_path
  end
end

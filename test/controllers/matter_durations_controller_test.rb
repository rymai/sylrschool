require 'test_helper'

class MatterDurationsControllerTest < ActionController::TestCase
  setup do
    @matter_duration = matter_durations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matter_durations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matter_duration" do
    assert_difference('MatterDuration.count') do
      post :create, matter_duration: { custo: @matter_duration.custo, description: @matter_duration.description, level_id: @matter_duration.level_id, name: @matter_duration.name, value: @matter_duration.value }
    end

    assert_redirected_to matter_duration_path(assigns(:matter_duration))
  end

  test "should show matter_duration" do
    get :show, id: @matter_duration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matter_duration
    assert_response :success
  end

  test "should update matter_duration" do
    patch :update, id: @matter_duration, matter_duration: { custo: @matter_duration.custo, description: @matter_duration.description, level_id: @matter_duration.level_id, name: @matter_duration.name, value: @matter_duration.value }
    assert_redirected_to matter_duration_path(assigns(:matter_duration))
  end

  test "should destroy matter_duration" do
    assert_difference('MatterDuration.count', -1) do
      delete :destroy, id: @matter_duration
    end

    assert_redirected_to matter_durations_path
  end
end

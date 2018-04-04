require 'test_helper'

class GradeContextsControllerTest < ActionController::TestCase
  setup do
    @grade_context = grade_contexts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grade_contexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grade_context" do
    assert_difference('GradeContext.count') do
      post :create, grade_context: { custo: @grade_context.custo, description: @grade_context.description, goal: @grade_context.goal, max_value: @grade_context.max_value, min_value: @grade_context.min_value, name: @grade_context.name }
    end

    assert_redirected_to grade_context_path(assigns(:grade_context))
  end

  test "should show grade_context" do
    get :show, id: @grade_context
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grade_context
    assert_response :success
  end

  test "should update grade_context" do
    patch :update, id: @grade_context, grade_context: { custo: @grade_context.custo, description: @grade_context.description, goal: @grade_context.goal, max_value: @grade_context.max_value, min_value: @grade_context.min_value, name: @grade_context.name }
    assert_redirected_to grade_context_path(assigns(:grade_context))
  end

  test "should destroy grade_context" do
    assert_difference('GradeContext.count', -1) do
      delete :destroy, id: @grade_context
    end

    assert_redirected_to grade_contexts_path
  end
end

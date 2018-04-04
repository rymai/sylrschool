require 'test_helper'

class TeacherMattersControllerTest < ActionController::TestCase
  setup do
    @teacher_matter = teacher_matters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_matters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_matter" do
    assert_difference('TeacherMatter.count') do
      post :create, teacher_matter: { custo: @teacher_matter.custo, matter_id: @teacher_matter.matter_id, teacher_id: @teacher_matter.teacher_id }
    end

    assert_redirected_to teacher_matter_path(assigns(:teacher_matter))
  end

  test "should show teacher_matter" do
    get :show, id: @teacher_matter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_matter
    assert_response :success
  end

  test "should update teacher_matter" do
    patch :update, id: @teacher_matter, teacher_matter: { custo: @teacher_matter.custo, matter_id: @teacher_matter.matter_id, teacher_id: @teacher_matter.teacher_id }
    assert_redirected_to teacher_matter_path(assigns(:teacher_matter))
  end

  test "should destroy teacher_matter" do
    assert_difference('TeacherMatter.count', -1) do
      delete :destroy, id: @teacher_matter
    end

    assert_redirected_to teacher_matters_path
  end
end

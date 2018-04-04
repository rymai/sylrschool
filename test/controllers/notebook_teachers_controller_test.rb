require 'test_helper'

class NotebookTeachersControllerTest < ActionController::TestCase
  setup do
    @notebook_teacher = notebook_teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notebook_teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notebook_teacher" do
    assert_difference('NotebookTeacher.count') do
      post :create, notebook_teacher: { custo: @notebook_teacher.custo, notebook_id: @notebook_teacher.notebook_id, teacher_id: @notebook_teacher.teacher_id }
    end

    assert_redirected_to notebook_teacher_path(assigns(:notebook_teacher))
  end

  test "should show notebook_teacher" do
    get :show, id: @notebook_teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notebook_teacher
    assert_response :success
  end

  test "should update notebook_teacher" do
    patch :update, id: @notebook_teacher, notebook_teacher: { custo: @notebook_teacher.custo, notebook_id: @notebook_teacher.notebook_id, teacher_id: @notebook_teacher.teacher_id }
    assert_redirected_to notebook_teacher_path(assigns(:notebook_teacher))
  end

  test "should destroy notebook_teacher" do
    assert_difference('NotebookTeacher.count', -1) do
      delete :destroy, id: @notebook_teacher
    end

    assert_redirected_to notebook_teachers_path
  end
end

require 'test_helper'

class StudentResponsiblesControllerTest < ActionController::TestCase
  setup do
    @student_responsible = student_responsibles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_responsibles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_responsible" do
    assert_difference('StudentResponsible.count') do
      post :create, student_responsible: { custo: @student_responsible.custo, responsible_id: @student_responsible.responsible_id, student_id: @student_responsible.student_id }
    end

    assert_redirected_to student_responsible_path(assigns(:student_responsible))
  end

  test "should show student_responsible" do
    get :show, id: @student_responsible
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_responsible
    assert_response :success
  end

  test "should update student_responsible" do
    patch :update, id: @student_responsible, student_responsible: { custo: @student_responsible.custo, responsible_id: @student_responsible.responsible_id, student_id: @student_responsible.student_id }
    assert_redirected_to student_responsible_path(assigns(:student_responsible))
  end

  test "should destroy student_responsible" do
    assert_difference('StudentResponsible.count', -1) do
      delete :destroy, id: @student_responsible
    end

    assert_redirected_to student_responsibles_path
  end
end

require 'test_helper'

class ClassSchoolsControllerTest < ActionController::TestCase
  setup do
    @class_school = class_schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_school" do
    assert_difference('ClassSchool.count') do
      post :create, class_school: { custo: @class_school.custo, default_location: @class_school.default_location, description: @class_school.description, name: @class_school.name, nb_max_student: @class_school.nb_max_student }
    end

    assert_redirected_to class_school_path(assigns(:class_school))
  end

  test "should show class_school" do
    get :show, id: @class_school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_school
    assert_response :success
  end

  test "should update class_school" do
    patch :update, id: @class_school, class_school: { custo: @class_school.custo, default_location: @class_school.default_location, description: @class_school.description, name: @class_school.name, nb_max_student: @class_school.nb_max_student }
    assert_redirected_to class_school_path(assigns(:class_school))
  end

  test "should destroy class_school" do
    assert_difference('ClassSchool.count', -1) do
      delete :destroy, id: @class_school
    end

    assert_redirected_to class_schools_path
  end
end

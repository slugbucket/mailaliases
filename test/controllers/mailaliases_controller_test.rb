require 'test_helper'

class MailaliasesControllerTest < ActionController::TestCase
  setup do
    @mailalias = mailaliases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mailaliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mailalias" do
    assert_difference('Mailalias.count') do
      post :create, mailalias: { cn: @mailalias.cn, description: @mailalias.description, rfc822mailmember: @mailalias.rfc822mailmember }
    end

    assert_redirected_to mailalias_path(assigns(:mailalias))
  end

  test "should show mailalias" do
    get :show, id: @mailalias
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mailalias
    assert_response :success
  end

  test "should update mailalias" do
    patch :update, id: @mailalias, mailalias: { cn: @mailalias.cn, description: @mailalias.description, rfc822mailmember: @mailalias.rfc822mailmember }
    assert_redirected_to mailalias_path(assigns(:mailalias))
  end

  test "should destroy mailalias" do
    assert_difference('Mailalias.count', -1) do
      delete :destroy, id: @mailalias
    end

    assert_redirected_to mailaliases_path
  end
end

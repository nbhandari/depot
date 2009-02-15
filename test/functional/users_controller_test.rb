require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures  :users

  def setup
    @request.session[:user_id] = users(:test).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { 
      :name => 'NewUser',
      :password => 'pwd',
      :password_confirmation => 'pwd'
      }
    end

    assert_redirected_to :action => :index
  end

  test "should show user" do
    get :show, :id => users(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users(:one).id
    assert_response :success
  end

  test "should update user" do
    put :update, :id => users(:one).id, :user => { }
    assert_redirected_to :action => :index
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end

    assert_redirected_to users_path
  end
  
  test "needs authentication" do
    @request.session[:user_id] = nil
    get :index
    assert_redirected_to :controller => 'admin', :action => 'login'
  end
  
  test "i am logged in" do
    @request.session[:user_id] = users(:one).id
    get :index
    assert_response :success
  end
  
  test "delete user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end
    
    assert_redirected_to :action => :index
  end
  
  test "delete last user" do
    all_users = User.find(:all)
    
    assert all_users.length>1
    
    assert_raise(RuntimeError) do
      loop do
        all_users.first.destroy
        all_users.shift
      end
    end
    
    assert_equal 1, all_users.length
  end
  
end

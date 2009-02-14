require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
  test "login" do
    testUser = users(:testLogin)
    
    post  :login, :name => testUser.name, :password => 'pwd1'
    
    assert_redirected_to  :action => :index
    assert_equal testUser.id, session[:user_id]
  end
  
  test "login failure" do
    testUser = users(:testLogin)
    
    post  :login, :name => testUser.name, :password => 'pwd2'
    
    assert_equal  "Invalid user/password", flash[:notice]
    assert_response  :success
  end

  test "logout" do
    #~ First login
    testUser = users(:testLogin)
    
    post  :login, :name => testUser.name, :password => 'pwd1'
    
    assert_redirected_to  :action => :index
    assert_equal testUser.id, session[:user_id]
    
    #~ Now logout
    post  :logout
    assert_nil  session[:user_id]
    assert_equal "Logged out", flash[:notice] 
    assert_redirected_to  :action => :login
  end
  
end

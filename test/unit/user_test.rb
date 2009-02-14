require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate" do
    user = users(:testLogin)
    authenticated_user = User.authenticate user.name, 'pwd1'
    
    assert_equal user, authenticated_user
  end
  
  test "authenticate failure" do
    user = users(:testLogin)
    authenticated_user = User.authenticate user.name, 'junk'
    
    assert_nil authenticated_user    
  end

end

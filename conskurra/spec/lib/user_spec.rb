require "spec_helper"
require "user"

describe User do
 it " should response to provider" do 
   should respond_to(:provider)
 end
  it " should response to uid" do 
   should respond_to(:uid)
 end
 it " should response to auth_token" do 
   should respond_to(:oauth_token)
 end
 
end
   
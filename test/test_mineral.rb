require 'helper'

class TestMineral < ActiveSupport::TestCase
  context "on GET to /handler/123" do
    setup do
      @response = Mineral::Rack::Mineral.new(stub).call({"REQUEST_METHOD" => "GET", "PATH_INFO" => "/handler/123"})
    end
    
    should "respond with 200" do
      assert_equal 200, @response[0]
    end
    
    should "respond with content type plain text" do
      assert_equal "text/plain", @response[1]['Content-type']
    end
    
    should "respond with id in body" do
      assert_equal ['123'], @response[2]
    end
  end
  
  context "on POST to /handler/123" do
    setup do
      env = {"REQUEST_METHOD" => "POST", "PATH_INFO" => "/handler/123"}
      app = stub(:app) do
        stubs(:call).with(env).returns("STUBBED")
      end
      @response = Mineral::Rack::Mineral.new(app).call(env)
    end
    
    should "call next in app stack" do
      assert_equal "STUBBED", @response
    end
  end
end

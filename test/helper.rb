require 'rubygems'
require 'active_support'
require 'rack'
require 'active_support/test_case'
require 'shoulda'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module Rails
  def self.root
    File.dirname(__FILE__)
  end
end


require 'mineral'

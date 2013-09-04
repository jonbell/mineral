require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)
require 'test/unit'
require 'shoulda'
require 'active_support/test_case'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


require 'mineral'

module Rails
  def self.root
    File.dirname(__FILE__)
  end
end


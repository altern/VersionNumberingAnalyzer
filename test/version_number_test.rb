# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_number'

class VersionNumberTest < Test::Unit::TestCase
  def test_parsing
    vn = VersionNumber.new("1.0.0")
    assert_equal(1, vn.firstVersionCompound)
  end
  
  def test_nil
    vn = VersionNumber.new("1.0.0")
    assert_equal true, vn.nil?(:fourthVersionCompound)
  end
  
  def test_zero
    vn = VersionNumber.new("1.0.0")
    assert_equal true, vn.zero?(:secondVersionCompound)
  end
  
  def test_zero_or_nil
    vn = VersionNumber.new("1.0.0")
    assert_equal true, vn.zeroOrNil?(:secondVersionCompound)
    assert_equal true, vn.zeroOrNil?(:fourthVersionCompound)
  end
end

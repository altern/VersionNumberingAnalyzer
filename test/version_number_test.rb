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
  
  def test_standalone_number
    vn = VersionNumber.new('1')
    assert_equal("1", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_nil(vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
  end
  
  def test_two_version_compounds
    vn = VersionNumber.new('1.0')
    assert_equal("1.0", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(0, vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
  end
  
  def test_multi_digit_version_compounds
    vn = VersionNumber.new('1.22.333.4444')
    assert_equal("1.22.333.4444", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(22, vn.secondVersionCompound)
    assert_equal(333, vn.thirdVersionCompound)
    assert_equal(4444, vn.fourthVersionCompound)
  end
  
  def test_simple_prefix
    vn = VersionNumber.new('v0.99')
    assert_equal("v0.99", vn.fullVersion)
    assert_equal("v", vn.prefix)
    assert_equal(0, vn.firstVersionCompound)
    assert_equal(99, vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
  end
  
  def test_complex_prefix_with_digits
    vn = VersionNumber.new('v111-0.99')
    
    assert_equal("v111-0.99", vn.fullVersion)
#    assert_equal("v111-", vn.prefix, vn.versionNumber)
#    assert_equal(0, vn.firstVersionCompound)
#    assert_equal(99, vn.secondVersionCompound)
#    assert_nil(vn.thirdVersionCompound)
#    assert_nil(vn.fourthVersionCompound)
    vn = VersionNumber.new('yui2-1909')
    assert_equal("yui2-1909", vn.fullVersion)
#    assert_equal("yui2-", vn.prefix, vn.versionNumber)
#    assert_equal("v111-", vn.prefix, vn.versionNumber)

  end
  
  def test_three_version_compounds
    vn = VersionNumber.new('1.0.2')
    assert_equal("1.0.2", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(0, vn.secondVersionCompound)
    assert_equal(2, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
  end
  
  def test_simple_suffix
    vn = VersionNumber.new('1.0.2-x32')
    assert_equal("1.0.2-x32", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(0, vn.secondVersionCompound)
    assert_equal(2, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal("x32", vn.suffixLabelWithNumber)
  end
  
  def test_complex_suffix
    vn = VersionNumber.new('3.0.0beta1m3')
    assert_equal("3.0.0beta1m3", vn.fullVersion)
    assert_equal(3, vn.firstVersionCompound)
    assert_equal(0, vn.secondVersionCompound)
    assert_equal(0, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal(1, vn.suffixNumber)
    assert_equal("m3", vn.postSuffix)
  end
  
  def test_four_version_compounds
    vn = VersionNumber.new('5.6.32.78')
    assert_equal("5.6.32.78", vn.fullVersion)
    assert_equal(5, vn.firstVersionCompound)
    assert_equal(6, vn.secondVersionCompound)
    assert_equal(32, vn.thirdVersionCompound)
    assert_equal(78, vn.fourthVersionCompound)
  end
  
  def test_version_number_placeholder
    vn = VersionNumber.new('5.x.0')
    assert_equal("5.x.0", vn.fullVersion)
    assert_equal(5, vn.firstVersionCompound)
    assert_equal("x", vn.secondVersionCompound)
    assert_equal(0, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    vn = VersionNumber.new('1.x.x')
    assert_equal("1.x.x", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal("x", vn.secondVersionCompound)
    assert_equal("x", vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    vn = VersionNumber.new('21.x.0.x')
    assert_equal("21.x.0.x", vn.fullVersion)
    assert_equal(21, vn.firstVersionCompound)
    assert_equal("x", vn.secondVersionCompound)
    assert_equal(0, vn.thirdVersionCompound)
    assert_equal("x", vn.fourthVersionCompound)
  end
  
  def test_separators
    vn = VersionNumber.new('v_3.4.5_p34')
    assert_equal("v_3.4.5_p34", vn.fullVersion)
    assert_equal(3, vn.firstVersionCompound)
    assert_equal(4, vn.secondVersionCompound)
    assert_equal(5, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal("p34", vn.suffixLabelWithNumber)
    vn = VersionNumber.new('a1.2.b51')
    assert_equal("a1.2.b51", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(2, vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal("b51", vn.suffixLabelWithNumber)
    vn = VersionNumber.new('standalone_3_2_51')
    assert_equal("standalone_3_2_51", vn.fullVersion)
    assert_equal(3, vn.firstVersionCompound)
    assert_equal(2, vn.secondVersionCompound)
    assert_equal(51, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    vn = VersionNumber.new('R 2.11.1 RC')
    assert_equal("R 2.11.1 RC", vn.fullVersion)
    assert_equal(2, vn.firstVersionCompound)
    assert_equal(11, vn.secondVersionCompound)
    assert_equal(1, vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal("RC", vn.suffixLabelWithNumber)
    vn = VersionNumber.new('RHEL 5 Update 11')
    assert_equal("RHEL 5 Update 11", vn.fullVersion)
    assert_equal(5, vn.firstVersionCompound)
    assert_nil(vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal(11, vn.suffixNumber)
    vn = VersionNumber.new("REL_1.10-rc-1")
    assert_equal("REL_1.10-rc-1", vn.fullVersion)
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(10, vn.secondVersionCompound)
    assert_nil(vn.thirdVersionCompound)
    assert_nil(vn.fourthVersionCompound)
    assert_equal("rc", vn.suffixLabel)
    assert_equal(1, vn.suffixNumber)
  end

  def test_decrement
    vn = VersionNumber.new("1.0.1")
    vn.decrement
    assert_equal(1, vn.firstVersionCompound)
    assert_equal(0, vn.getCompoundById(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    assert_equal(0, vn.getCompoundById(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    vn = VersionNumber.new("1.0.1-32")
    vn.decrement
    assert_equal(1, vn.getCompoundById(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    assert_equal(0, vn.getCompoundById(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    assert_equal(1, vn.getCompoundById(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    assert_equal(31, vn.getCompoundById(VersionNumber.versionCompoundMethods[:suffixNumber]))
  end
  
end

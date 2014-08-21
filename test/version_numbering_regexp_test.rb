# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_numbering_analyzer'

class VersionNumberingRegexpTest < Test::Unit::TestCase
  
  def setup
    @vna = VersionNumberingAnalyzer.new
  end
  
  def test_standalone_number
    @vna.version = '1'
    assert_equal("1", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_nil(@vna.secondVersionCompound)
    assert_nil(@vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
  end
  
  def test_two_version_compounds
    @vna.version = '1.0'
    assert_equal("1.0", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("0", @vna.secondVersionCompound)
    assert_nil(@vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
  end
  
  def test_multi_digit_version_compounds
    @vna.version = '1.22.333.4444'
    assert_equal("1.22.333.4444", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("22", @vna.secondVersionCompound)
    assert_equal("333", @vna.thirdVersionCompound)
    assert_equal("4444", @vna.fourthVersionCompound)
  end
  
  def test_simple_prefix
    @vna.version = 'v0.99'
    assert_equal("v0.99", @vna.fullVersion)
    assert_equal("v", @vna.prefix)
    assert_equal("0", @vna.firstVersionCompound)
    assert_equal("99", @vna.secondVersionCompound)
    assert_nil(@vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
  end
  
#  def test_complex_prefix_with_digits
#    @vna.version = 'v111-0.99'
#    assert_equal("v111-0.99", @vna.fullVersion)
#    assert_equal("v111-", @vna.prefix)
#    assert_equal("0", @vna.firstVersionCompound)
#    assert_equal("99", @vna.secondVersionCompound)
#    assert_nil(@vna.thirdVersionCompound)
#    assert_nil(@vna.fourthVersionCompound)
#  end
  
  def test_three_version_compounds
    @vna.version = '1.0.2'
    assert_equal("1.0.2", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("0", @vna.secondVersionCompound)
    assert_equal("2", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
  end
  
  def test_simple_suffix
    @vna.version = '1.0.2-x32'
    assert_equal("1.0.2-x32", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("0", @vna.secondVersionCompound)
    assert_equal("2", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    assert_equal("x32", @vna.suffixLabelWithNumber)
  end
  
  def test_four_version_compounds
    @vna.version = '5.6.32.78'
    assert_equal("5.6.32.78", @vna.fullVersion)
    assert_equal("5", @vna.firstVersionCompound)
    assert_equal("6", @vna.secondVersionCompound)
    assert_equal("32", @vna.thirdVersionCompound)
    assert_equal("78", @vna.fourthVersionCompound)
  end
  
  def test_version_number_placeholder
    @vna.version = '5.x.0'
    assert_equal("5.x.0", @vna.fullVersion)
    assert_equal("5", @vna.firstVersionCompound)
    assert_equal("x", @vna.secondVersionCompound)
    assert_equal("0", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    @vna.version = '1.x.x'
    assert_equal("1.x.x", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("x", @vna.secondVersionCompound)
    assert_equal("x", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    @vna.version = '21.x.0.x'
    assert_equal("21.x.0.x", @vna.fullVersion)
    assert_equal("21", @vna.firstVersionCompound)
    assert_equal("x", @vna.secondVersionCompound)
    assert_equal("0", @vna.thirdVersionCompound)
    assert_equal("x", @vna.fourthVersionCompound)
  end
  
  def test_separators
    @vna.version = 'v_3.4.5_p34'
    assert_equal("v_3.4.5_p34", @vna.fullVersion)
    assert_equal("3", @vna.firstVersionCompound)
    assert_equal("4", @vna.secondVersionCompound)
    assert_equal("5", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    assert_equal("p34", @vna.suffixLabelWithNumber)
    @vna.version = 'a1.2.b51'
    assert_equal("a1.2.b51", @vna.fullVersion)
    assert_equal("1", @vna.firstVersionCompound)
    assert_equal("2", @vna.secondVersionCompound)
    assert_nil(@vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    assert_equal("b51", @vna.suffixLabelWithNumber)
    @vna.version = 'standalone_3_2_51'
    assert_equal("standalone_3_2_51", @vna.fullVersion)
    assert_equal("3", @vna.firstVersionCompound)
    assert_equal("2", @vna.secondVersionCompound)
    assert_equal("51", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    @vna.version = 'R 2.11.1 RC'
    assert_equal("R 2.11.1 RC", @vna.fullVersion)
    assert_equal("2", @vna.firstVersionCompound)
    assert_equal("11", @vna.secondVersionCompound)
    assert_equal("1", @vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    assert_equal("RC", @vna.suffixLabelWithNumber)
    @vna.version = 'RHEL 5 Update 11'
    assert_equal("RHEL 5 Update 11", @vna.fullVersion)
    assert_equal("5", @vna.firstVersionCompound)
    assert_nil(@vna.secondVersionCompound)
    assert_nil(@vna.thirdVersionCompound)
    assert_nil(@vna.fourthVersionCompound)
    assert_equal("11", @vna.suffixNumber)
  end
  
end

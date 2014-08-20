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
  
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_numbering_analyzer'
require 'utils'

class VersionNumberingAnalyzerTest < Test::Unit::TestCase
  
  def setup
    @vna = VersionNumberingAnalyzer.new
    @vna.releaseHistory = Utils.readFileToArray('test/git_release_history.txt')
    @number_of_release_history_entiries = 486
  end
  
  def test_number_of_release_history_entries
    assert_equal(@number_of_release_history_entiries, @vna.releaseHistory.length)
  end
  
  def test_number_of_parsed_versions
    assert_equal(@number_of_release_history_entiries, @vna.parsedVersions.length)
  end
  
  def test_number_of_unique_values
    assert_equal(3, @vna.uniqueValues[@vna.versionCompoundMethods[:firstVersionCompound]].length)
    assert_equal(11, @vna.uniqueValues[@vna.versionCompoundMethods[:secondVersionCompound]].length)
    assert_equal(15, @vna.uniqueValues[@vna.versionCompoundMethods[:thirdVersionCompound]].length)
    assert_equal(10, @vna.uniqueValues[@vna.versionCompoundMethods[:fourthVersionCompound]].length)
    assert_equal(16, @vna.uniqueValues[@vna.versionCompoundMethods[:suffixLabel]].length)
    assert_equal(9, @vna.uniqueValues[@vna.versionCompoundMethods[:suffixNumber]].length)
  end
  
  def test_increments
    @vna.releaseHistory = ['0.1','0.2','0.3']
    assert_equal(0, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(2, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0','1.1','1.2', '1.3', '2.0', '2.1']
    assert_equal(1, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(4, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1']
    assert_equal(1, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(1, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(3, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:thirdVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2']
    assert_equal(1, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(3, @vna.getIncrementMetrics.increments[@vna.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_empty_jumps
    @vna.releaseHistory = ['0.1','0.2','0.3']
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0','1.1','1.2', '1.3', '2.0', '2.1']
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1']
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(1, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:thirdVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2']
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.emptyJumps[@vna.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_jumps
    @vna.releaseHistory = ['0.1','0.2','0.3']
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0','1.1','1.2', '1.3', '2.0', '2.1']
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1']
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:thirdVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2']
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(2, @vna.getIncrementMetrics.jumps[@vna.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_cycle_lengths
    @vna.releaseHistory = ['0.1','0.2','0.3']
    assert_equal([], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([2], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0','1.1','1.2', '1.3', '2.0', '2.1']
#    assert_equal([1], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([3,1], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:secondVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1']
#    assert_equal([1], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([1], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:secondVersionCompound]])
#    assert_equal([3], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:thirdVersionCompound]])
    @vna.releaseHistory = ['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2']
#    assert_equal([1], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([0], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:secondVersionCompound]])
#    assert_equal([3,2], @vna.getIncrementMetrics.cycleLengths[@vna.versionCompoundMethods[:thirdVersionCompound]])
  end
  
end

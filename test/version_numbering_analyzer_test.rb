# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_numbering_analyzer'
require 'utils'

class VersionNumberingAnalyzerTest < Test::Unit::TestCase
  
  def setup
    @vna = VersionNumberingAnalyzer.new(Utils.readFileToArray('test/git_release_history.txt'))
    @number_of_release_history_entiries = 486
  end
  
  def test_number_of_release_history_entries
    assert_equal(@number_of_release_history_entiries, @vna.releaseHistory.length)
  end
  
  def test_number_of_parsed_versions
    assert_equal(@number_of_release_history_entiries, @vna.parsedVersions.length)
  end
  
  def test_number_of_unique_values
    assert_equal(3, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]].length, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(11, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:secondVersionCompound]].length)
    assert_equal(15, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].length)
    assert_equal(10, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].length)
    assert_equal(16, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:suffixLabel]].length)
    assert_equal(9, @vna.uniqueValues[VersionNumber.versionCompoundMethods[:suffixNumber]].length)
  end
  
  def test_increments
    @vna = VersionNumberingAnalyzer.new(['0.1','0.2','0.3'])
    assert_equal(0, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]], @vna.versionInconsistencies.increments)
    assert_equal(2, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:secondVersionCompound]], @vna.versionInconsistencies.increments)
    @vna = VersionNumberingAnalyzer.new(['1.0','1.1','1.2', '1.3', '2.0', '2.1'])
    assert_equal(1, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(4, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1'])
    assert_equal(1, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(1, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(3, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2'])
    assert_equal(1, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(3, @vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_empty_jumps
    @vna = VersionNumberingAnalyzer.new(['0.1','0.2','0.3'])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0','1.1','1.2', '1.3', '2.0', '2.1'])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1'])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
#    assert_equal(1, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2'])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]], @vna.versionInconsistencies.emptyJumps)
  end
  
  def test_jumps
    @vna = VersionNumberingAnalyzer.new(['0.1','0.2','0.3'])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0','1.1','1.2', '1.3', '2.0', '2.1'])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1'])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2'])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal(0, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal(2, @vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_jump_pairs
    @vna = VersionNumberingAnalyzer.new(['0.1','0.2','0.3'])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0','1.1','1.2', '1.3', '2.0', '2.1'])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1'])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2'])
#    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:firstVersionCompound]], @vna.versionInconsistencies.jumpPairs)
#    assert_equal([], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    assert_equal([['1.0.1','1.0.3']], @vna.versionInconsistencies.jumpPairs[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
  end
  
  def test_cycle_lengths
    @vna = VersionNumberingAnalyzer.new(['0.1','0.2','0.3'])
    assert_equal([], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([2], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0','1.1','1.2', '1.3', '2.0', '2.1'])
#    assert_equal([1], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([3,1], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.2', '1.0.3', '2.0', '2.1'])
#    assert_equal([1], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([1], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
#    assert_equal([3], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
    @vna = VersionNumberingAnalyzer.new(['1.0.0','1.0.1','1.0.3', '1.0.4', '2.0.1', '2.0.2'])
#    assert_equal([1], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]])
#    assert_equal([0], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]])
#    assert_equal([3,2], @vna.versionInconsistencies.cycleLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]])
  end
  
end

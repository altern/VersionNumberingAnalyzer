# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_inconsistencies'
require 'version_numbering_analyzer'
require 'version_number'

class VersionInconsistenciesTest < Test::Unit::TestCase
  
  def setup
    @vi = VersionInconsistencies.new
    @vna = VersionNumberingAnalyzer.new
  end
  
  def test_initialize
    assert_equal(@vna.versionCompoundMethods.length, @vi.increments.length)
#    assert_equal(@vna.versionCompoundMethods.length, @vi.cycles.length)
    assert_equal(@vna.versionCompoundMethods.length, @vi.jumps.length)
    assert_equal(@vna.versionCompoundMethods.length, @vi.cycleLengths.length)
    assert_equal(@vna.versionCompoundMethods.length, @vi.emptyJumps.length)
  end
  
  def test_increment_version_compound
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.increments(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.increments(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.increments(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.increments(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.increments(@vna.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.increments(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.increments(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.increments(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.increments(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementVersionCompound(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.increments(@vna.versionCompoundMethods[:suffixNumber]))
  end
  
#  def test_increment_cycle
#    @vi.incrementCycle(@vna.versionCompoundMethods[:firstVersionCompound])
#    assert_equal(1, @vi.cycles(@vna.versionCompoundMethods[:firstVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:secondVersionCompound])
#    assert_equal(1, @vi.cycles(@vna.versionCompoundMethods[:secondVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:thirdVersionCompound])
#    assert_equal(1, @vi.cycles(@vna.versionCompoundMethods[:thirdVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:fourthVersionCompound])
#    assert_equal(1, @vi.cycles(@vna.versionCompoundMethods[:fourthVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:suffixNumber])
#    assert_equal(1, @vi.cycles(@vna.versionCompoundMethods[:suffixNumber]))
#    
#    @vi.incrementCycle(@vna.versionCompoundMethods[:firstVersionCompound])
#    assert_equal(2, @vi.cycles(@vna.versionCompoundMethods[:firstVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:secondVersionCompound])
#    assert_equal(2, @vi.cycles(@vna.versionCompoundMethods[:secondVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:thirdVersionCompound])
#    assert_equal(2, @vi.cycles(@vna.versionCompoundMethods[:thirdVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:fourthVersionCompound])
#    assert_equal(2, @vi.cycles(@vna.versionCompoundMethods[:fourthVersionCompound]))
#    @vi.incrementCycle(@vna.versionCompoundMethods[:suffixNumber])
#    assert_equal(2, @vi.cycles(@vna.versionCompoundMethods[:suffixNumber]))
#  end
  
  def test_increment_jump
    @vi.incrementJump(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.jumps(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.jumps(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.jumps(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.jumps(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.jumps(@vna.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementJump(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.jumps(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.jumps(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.jumps(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.jumps(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementJump(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.jumps(@vna.versionCompoundMethods[:suffixNumber]))
  end
  
  def test_add_cycle_length
    @vi.addCycleLength(@vna.versionCompoundMethods[:firstVersionCompound], 1)
    assert_equal([1], @vi.cycleLengths(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:secondVersionCompound], 2)
    assert_equal([2], @vi.cycleLengths(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:thirdVersionCompound], 3)
    assert_equal([3], @vi.cycleLengths(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:fourthVersionCompound], 4)
    assert_equal([4], @vi.cycleLengths(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:suffixNumber], 5)
    assert_equal([5], @vi.cycleLengths(@vna.versionCompoundMethods[:suffixNumber]))
    
    @vi.addCycleLength(@vna.versionCompoundMethods[:firstVersionCompound], 2)
    assert_equal([1, 2], @vi.cycleLengths(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:secondVersionCompound], 3)
    assert_equal([2, 3], @vi.cycleLengths(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:thirdVersionCompound], 4)
    assert_equal([3, 4], @vi.cycleLengths(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:fourthVersionCompound], 5)
    assert_equal([4, 5], @vi.cycleLengths(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.addCycleLength(@vna.versionCompoundMethods[:suffixNumber], 6)
    assert_equal([5, 6], @vi.cycleLengths(@vna.versionCompoundMethods[:suffixNumber]))
  end
  
  def test_increment_empty_jump
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.emptyJumps(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.emptyJumps(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.emptyJumps(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.emptyJumps(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.emptyJumps(@vna.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.emptyJumps(@vna.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.emptyJumps(@vna.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.emptyJumps(@vna.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.emptyJumps(@vna.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementEmptyJump(@vna.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.emptyJumps(@vna.versionCompoundMethods[:suffixNumber]))
  end
  
  def test_version_megalomania_severity
    severity = @vi.versionMegalomaniaSeverity(VersionNumber.new("1.2.1"), VersionNumber.new("1.3.0"))
    assert_equal(1, severity)
    severity = @vi.versionMegalomaniaSeverity(VersionNumber.new("1.3.4"), VersionNumber.new("2.0.0"))
    assert_equal(2, severity)
    severity = @vi.versionMegalomaniaSeverity(VersionNumber.new("1.3.4.6"), VersionNumber.new("2.0.0"))
    assert_equal(3, severity)
    version1 = VersionNumber.new("3.0.0beta1m3")
    version2 = VersionNumber.new("3.0.0pr2")
    severity = @vi.versionMegalomaniaSeverity(version1, version2)
    assert_equal(0, severity, version1.to_s + ", " + version2.to_s)
    severity = @vi.versionMegalomaniaSeverity(VersionNumber.new("1.3.4.6-rc4"), VersionNumber.new("2.0.0.0-rc0"))
    assert_equal(4, severity)
  end
  
  def test_add_megalomania_severities
    assert_equal [], @vi.megalomaniaSeverities
    @vi.addMegalomaniaSeverity(2)
    assert_equal [2], @vi.megalomaniaSeverities
    @vi.addMegalomaniaSeverity(3)
    assert_equal [2, 3], @vi.megalomaniaSeverities
  end
  
  def test_add_megalomania_severity_pairs
    assert_equal [], @vi.megalomaniaSeverityPairs
    @vi.addMegalomaniaSeverityPair("1.0.1", "2.0.0")
    assert_equal [ ["1.0.1", "2.0.0"] ], @vi.megalomaniaSeverityPairs
    @vi.addMegalomaniaSeverityPair("2.1.0", "3.0.0")
    assert_equal [ ["1.0.1", "2.0.0"], ["2.1.0", "3.0.0"] ], @vi.megalomaniaSeverityPairs
  end
  
end

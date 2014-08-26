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
    @vna = VersionNumberingAnalyzer.new
    @vi = @vna.versionInconsistencies
  end
  
  def test_initialize
    assert_equal(VersionNumber.versionCompoundMethods.length, @vi.increments.length)
#    assert_equal(VersionNumber.versionCompoundMethods.length, @vi.cycles.length)
    assert_equal(VersionNumber.versionCompoundMethods.length, @vi.jumps.length)
    assert_equal(VersionNumber.versionCompoundMethods.length, @vi.cycleLengths.length)
    assert_equal(VersionNumber.versionCompoundMethods.length, @vi.emptyJumps.length)
  end
  
  def test_increment_version_compound
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.increments(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.increments(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.increments(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.increments(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.increments(VersionNumber.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.increments(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.increments(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.increments(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.increments(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementVersionCompound(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.increments(VersionNumber.versionCompoundMethods[:suffixNumber]))
  end
  
#  def test_increment_cycle
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:firstVersionCompound])
#    assert_equal(1, @vi.cycles(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:secondVersionCompound])
#    assert_equal(1, @vi.cycles(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
#    assert_equal(1, @vi.cycles(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
#    assert_equal(1, @vi.cycles(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:suffixNumber])
#    assert_equal(1, @vi.cycles(VersionNumber.versionCompoundMethods[:suffixNumber]))
#    
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:firstVersionCompound])
#    assert_equal(2, @vi.cycles(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:secondVersionCompound])
#    assert_equal(2, @vi.cycles(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
#    assert_equal(2, @vi.cycles(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
#    assert_equal(2, @vi.cycles(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
#    @vi.incrementCycle(VersionNumber.versionCompoundMethods[:suffixNumber])
#    assert_equal(2, @vi.cycles(VersionNumber.versionCompoundMethods[:suffixNumber]))
#  end
  
  def test_increment_jump
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.jumps(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.jumps(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.jumps(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.jumps(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.jumps(VersionNumber.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.jumps(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.jumps(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.jumps(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.jumps(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementJump(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.jumps(VersionNumber.versionCompoundMethods[:suffixNumber]))
  end
  
  def test_add_cycle_length
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:firstVersionCompound], 1)
    assert_equal([1], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:secondVersionCompound], 2)
    assert_equal([2], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:thirdVersionCompound], 3)
    assert_equal([3], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:fourthVersionCompound], 4)
    assert_equal([4], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:suffixNumber], 5)
    assert_equal([5], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:suffixNumber]))
    
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:firstVersionCompound], 2)
    assert_equal([1, 2], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:secondVersionCompound], 3)
    assert_equal([2, 3], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:thirdVersionCompound], 4)
    assert_equal([3, 4], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:fourthVersionCompound], 5)
    assert_equal([4, 5], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.addCycleLength(VersionNumber.versionCompoundMethods[:suffixNumber], 6)
    assert_equal([5, 6], @vi.cycleLengths(VersionNumber.versionCompoundMethods[:suffixNumber]))
  end
  
  def test_increment_empty_jump
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(1, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(1, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(1, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(1, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(1, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:suffixNumber]))
    
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:firstVersionCompound])
    assert_equal(2, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:firstVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:secondVersionCompound])
    assert_equal(2, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:secondVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:thirdVersionCompound])
    assert_equal(2, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:thirdVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:fourthVersionCompound])
    assert_equal(2, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:fourthVersionCompound]))
    @vi.incrementEmptyJump(VersionNumber.versionCompoundMethods[:suffixNumber])
    assert_equal(2, @vi.emptyJumps(VersionNumber.versionCompoundMethods[:suffixNumber]))
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

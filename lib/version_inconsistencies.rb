require 'version_numbering_analyzer'
require 'utils'

class VersionInconsistencies
  attr_accessor :increments, :cycles, :jumps, :cycleLengths, :emptyJumps, :versionPlaceholders
  
  def initialize
    @vna = VersionNumberingAnalyzer.new
    @increments = Array.new(@vna.versionCompoundMethods.length, 0)
#    @cycles = Array.new(@vna.versionCompoundMethods.length, 0)
    @jumps = Array.new(@vna.versionCompoundMethods.length, 0)
    @jumpPairs = Array.new(@vna.versionCompoundMethods.length, [])
    @cycleLengths = Array.new(@vna.versionCompoundMethods.length, [])
    @megalomaniaSeverities = []
    @megalomaniaSeverityPairs = []
    @emptyJumps = Array.new(@vna.versionCompoundMethods.length, 0)
    @versionPlaceholders = Array.new(@vna.versionCompoundMethods.length, 0)
  end
  
  def incrementVersionCompound(compoundId)
    if !@increments[compoundId].nil?
      @increments[compoundId] += 1
    else
      @increments[compoundId] = 1
    end
  end
#  
#  def incrementCycle(compoundId)
#    if !@cycles[compoundId].nil?
#      @cycles[compoundId] += 1
#    else
#      @cycles[compoundId] = 1
#    end
#  end
#  
  def incrementJump(compoundId)
    if !@jumps[compoundId].nil?
      @jumps[compoundId] += 1
    else
      @jumps[compoundId] = 1
    end
  end
  
  def addJumpPair(compoundId, version1, version2)
    if !@jumpPairs[compoundId].nil?
      @jumpPairs[compoundId] << [version1, version2]
    else
      @jumpPairs[compoundId] = [version1, version2]
    end
  end
  
  def addCycleLength(compoundId, length)
    if @cycleLengths[compoundId].empty?
      @cycleLengths[compoundId] = [length]
    else
      @cycleLengths[compoundId] << length
    end
  end
  
  def addMegalomaniaSeverity(severity)
    @megalomaniaSeverities << severity
  end
  
  def addMegalomaniaSeverityPair(version1, version2)
    @megalomaniaSeverityPairs << [version1, version2]
  end
  
  def incrementVersionPlaceholder(compoundId)
    if !@versionPlaceholders[compoundId].nil?
      @versionPlaceholders[compoundId] += 1
    else
      @versionPlaceholders[compoundId] = 1
    end
  end
  
  def incrementEmptyJump(compoundId)
    if !@emptyJumps[compoundId].nil?
      @emptyJumps[compoundId] += 1
    else
      @emptyJumps[compoundId] = 1
    end
  end
  
  def increments(*args) 
    if args.length == 1
      compoundId = args[0]
      @increments[compoundId] unless @increments[compoundId].nil?
    else 
      @increments
    end
  end
#  
#  def cycles(*args) 
#    if args.length == 1
#      compoundId = args[0]
#      @cycles[compoundId] unless @cycles[compoundId].nil?
#    else
#      @cycles
#    end
#  end
  
  def jumps(*args) 
    if args.length == 1
      compoundId = args[0]
      @jumpPairs[compoundId].length unless @jumpPairs[compoundId].nil?
    else 
      @jumpPairs.map{ |elem| elem.length }
    end
  end
  
  def jumps(*args) 
    if args.length == 1
      compoundId = args[0]
      @jumps[compoundId] unless @jumps[compoundId].nil?
    else 
      @jumps
    end
  end
  
  def jumpPairs(*args) 
    if args.length == 1
      compoundId = args[0]
      @jumpPairs[compoundId] unless @jumpPairs[compoundId].nil?
    else 
      @jumpPairs
    end
  end

  def cycleLengths(*args)
    if args.length == 1
      compoundId = args[0]
      @cycleLengths[compoundId] unless @cycleLengths[compoundId].nil? 
    else 
      @cycleLengths
    end
  end

  def megalomaniaSeverities
    @megalomaniaSeverities
  end

  def megalomaniaSeverityPairs
    @megalomaniaSeverityPairs
  end
  
  def emptyJumps(*args)
    if args.length == 1
      compoundId = args[0]
      @emptyJumps[compoundId] unless @emptyJumps[compoundId].nil?
    else 
      @emptyJumps
    end
  end
  
  def versionPlaceholders(*args)
    if args.length == 1
      compoundId = args[0]
      @versionPlaceholders[compoundId] unless @versionPlaceholders[compoundId].nil?
    else 
      @versionPlaceholders
    end
  end
  
  def versionMegalomaniaSeverity(firstVersion, secondVersion)
    severity = 0
    severity += 1 unless firstVersion.zeroOrNil?(:firstVersionCompound) || !secondVersion.zeroOrNil?(:firstVersionCompound)
    severity += 1 unless firstVersion.zeroOrNil?(:secondVersionCompound) || !secondVersion.zeroOrNil?(:secondVersionCompound)
    severity += 1 unless firstVersion.zeroOrNil?(:thirdVersionCompound) || !secondVersion.zeroOrNil?(:thirdVersionCompound)
    severity += 1 unless firstVersion.zeroOrNil?(:fourthVersionCompound) || !secondVersion.zeroOrNil?(:fourthVersionCompound)
    severity += 1 unless firstVersion.zeroOrNil?(:suffixNumber) || !secondVersion.zeroOrNil?(:suffixNumber)
    severity
  end
end
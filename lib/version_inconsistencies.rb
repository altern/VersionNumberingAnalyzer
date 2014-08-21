require 'version_numbering_analyzer'

class VersionInconsistencies
  attr_accessor :increments, :cycles, :jumps, :cycleLengths, :emptyJumps
  
  def initialize
    @vna = VersionNumberingAnalyzer.new
    @increments = Array.new(@vna.versionCompoundMethods.length)
    @cycles = Array.new(@vna.versionCompoundMethods.length)
    @jumps = Array.new(@vna.versionCompoundMethods.length)
    @cycleLengths = Array.new(@vna.versionCompoundMethods.length)
    @emptyJumps = Array.new(@vna.versionCompoundMethods.length)
  end
  
  def incrementVersionCompound(compoundId)
    if !@increments[compoundId].nil?
      @increments[compoundId] += 1
    else
      @increments[compoundId] = 1
    end
  end
  
  def incrementCycle(compoundId)
    if !@cycles[compoundId].nil?
      @cycles[compoundId] += 1
    else
      @cycles[compoundId] = 1
    end
  end
  
  def incrementJump(compoundId)
    if !@jumps[compoundId].nil?
      @jumps[compoundId] += 1
    else
      @jumps[compoundId] = 1
    end
  end
  
  def addCycleLength(compoundId, length)
    if @cycleLengths[compoundId].nil?
      @cycleLengths[compoundId] = [length]
    else
      @cycleLengths[compoundId] << length
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
  
  def cycles(*args) 
    if args.length == 1
      compoundId = args[0]
      @cycles[compoundId] unless @cycles[compoundId].nil?
    else
      @cycles
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

  def cycleLengths(*args)
    if args.length == 1
      compoundId = args[0]
      @cycleLengths[compoundId] unless @cycleLengths[compoundId].nil?
    else 
      @cycleLengths
    end
  end
  
  def emptyJumps(*args)
    if args.length == 1
      compoundId = args[0]
      @emptyJumps[compoundId] unless @emptyJumps[compoundId].nil?
    else 
      @emptyJumps
    end
  end
  
end
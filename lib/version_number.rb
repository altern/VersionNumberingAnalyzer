require 'utils'

class VersionNumber
  
  attr_accessor :versionNumber
  
  def initialize(version)
    @versionPattern = /^(\D+[\._\-\s]?)?(\d+)([\._\-\s]([\dx]+))?([\._]([\dx]+))?([\._]([\dx]+))?([\._]([\dx]+))?(([-_\.\s]?(([a-zA-Z]*)[-_\s]?(\d*)))?(.*)?)?$/
    @versionNumber = Array.new(@@versionCompoundMethods.length, nil)
    matches = @versionPattern.match(version)
    if !matches.nil? then
      @@versionCompoundMethods.each { |method_name,index|
        compound = matches[@@versionCompoundMethods[method_name]]
        compoundNum = try_to_i compound
        if (@@numericalCompounds.include? method_name) && !compoundNum.nil?
          @versionNumber[index] = compoundNum
        else 
          @versionNumber[index] = compound
        end
      }
    end
  end
  
  def nil?(compoundId)
    getCompoundById(compoundId).nil?
  end

  def zero?(compoundId)
    getCompoundById(compoundId) == 0
  end
  
  def zeroOrNil?(compoundId)
    nil?(compoundId) || zero?(compoundId)
  end
  
  def to_s
    firstVersionCompound.to_s + " " + secondVersionCompound.to_s + " " + thirdVersionCompound.to_s + " " + fourthVersionCompound.to_s + " " + suffixNumber.to_s
  end
  
  @@versionCompoundMethods = {
    :fullVersion => 0,
    :prefix => 1,
    :firstVersionCompound => 2,
    :firstVersionCompoundWithSeparator => 3,
    :secondVersionCompound => 4,
    :secondVersionCompoundWithSeparator => 5,
    :thirdVersionCompound => 6,
    :thirdVersionCompoundWithSeparator => 7,
    :fourthVersionCompound => 8,
    :x1 => 9,
    :x2 => 10,
    :x3 => 11,
    :fullSuffix => 12,
    :suffixLabelWithNumber => 13,
    :suffixLabel => 14,
    :suffixNumber => 15,
    :postSuffix => 16,
  }
  
  @@numericalCompounds = [
    :firstVersionCompound, 
    :secondVersionCompound,
    :thirdVersionCompound,
    :fourthVersionCompound,
    :suffixNumber
  ]
  
  def self.versionCompoundMethods
    @@versionCompoundMethods
  end
  
  def self.numericCompounds
    @@versionCompoundMethods.find_all { |method,key| @@numericalCompounds.include?(method) }
  end
  
  def_each @@versionCompoundMethods.keys do |method_name|
    getCompoundById(method_name)
  end
    
  def getCompounds 
    if !@versionNumber.nil? then
      @versionNumber
    end
  end
  
  def getCompoundById compoundId
    if !@versionNumber.nil? then
      if compoundId.class == Symbol
        @versionNumber[@@versionCompoundMethods[compoundId]]
      else
        @versionNumber[compoundId]
      end
    end
  end
  
end

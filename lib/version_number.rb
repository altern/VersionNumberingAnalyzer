require 'version_numbering_analyzer'
require 'utils'

class VersionNumber
  def initialize(version)
    @vna = VersionNumberingAnalyzer.new
    @vna.version = version
    @versionNumber = @vna.getCompounds
  end
  
  def nil?(key)
    @versionNumber[@vna.versionCompoundMethods[key]].nil?
  end

  def zero?(key)
    @versionNumber[@vna.versionCompoundMethods[key]] == "0"
  end
  
  def zeroOrNil?(key)
    if !@versionNumber.nil?
      @versionNumber[@vna.versionCompoundMethods[key]].nil? || @versionNumber[@vna.versionCompoundMethods[key]] == "0"
    end
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
  
  def_each @@versionCompoundMethods.keys do |method_name|
    compound = @vna.getCompoundById(@vna.versionCompoundMethods[method_name])
    compoundNum = try_to_i compound
    if compoundNum.nil?
      compound
    else
      compoundNum
    end
  end
  
end

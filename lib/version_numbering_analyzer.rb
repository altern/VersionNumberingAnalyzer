# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require 'version_inconsistencies'
require 'version_number'
require 'utils'

# TODOs:
# how far do versions jump?
# empty jumps - expansions vs reductions
# metrics of jump severity
# aggregate metric for version compound jumps
# metrics of soft ambiguity
# come up with megalomania indicator 
# come up with indicator for soft megalomania (intermediate RCs)


class VersionNumberingAnalyzer
  
  attr_accessor :releaseHistory, :versionInconsistencies, :lengthOfLongestVersion
  
  def initialize(releaseHistory = nil)
    @releaseHistory = releaseHistory
    @versionInconsistencies = VersionInconsistencies.new
    @lengthOfLongestVersion = 0
    if !@releaseHistory.nil? then 
      @releaseHistory.each_with_index{ |strVersion, i|
        if i != 0
          strVersion1 = @releaseHistory[i-1]
          strVersion2 = @releaseHistory[i]
          version1 = VersionNumber.new(strVersion1)
          version2 = VersionNumber.new(strVersion2)
          version1Length = version1.numberOfCompounds
          version2Length = version2.numberOfCompounds
          @lengthOfLongestVersion = (version1Length > @lengthOfLongestVersion ? version1Length : @lengthOfLongestVersion )
          @lengthOfLongestVersion = (version2Length > @lengthOfLongestVersion ? version2Length : @lengthOfLongestVersion )
          severity = @versionInconsistencies.versionMegalomaniaSeverity(VersionNumber.new(strVersion1), VersionNumber.new(strVersion2))
          
          VersionNumber.numericCompounds.each { |key, value|
            if key.class == Symbol
              compoundId = VersionNumber.versionCompoundMethods[key]
            else 
              compoundId = key
            end
          
            compound1 = version1.getCompoundById(compoundId)
            compound2 = version2.getCompoundById(compoundId)
            if compound2 == 'x'
              @versionInconsistencies.incrementVersionPlaceholder(compoundId)
            end
            if compound2.nil? ^ compound1.nil?
              @versionInconsistencies.incrementEmptyJump(compoundId)
              @versionInconsistencies.addEmptyJumpValue(compoundId, version2Length)
            elsif compound2.class == Fixnum && compound1.class == Fixnum
              if (compound2 - compound1 == 1) then
                @versionInconsistencies.incrementVersionCompound(compoundId)
              elsif ( compound2 - compound1 >= 2 ) && (!compound1.nil? && !compound2.nil?) || (compound2 < compound1 && compound2 > 0)
                @versionInconsistencies.incrementJump(compoundId)
                @versionInconsistencies.addJumpLength(compoundId, compound2 < compound1 ? compound2 : compound2 - compound1)
                @versionInconsistencies.addJumpPair(compoundId, strVersion1, strVersion2)
              end
            end
          }
          
          if (severity != 0)
            @versionInconsistencies.addMegalomaniaSeverity(severity)
            @versionInconsistencies.addMegalomaniaSeverityPair(strVersion1, strVersion2)
          end
        end
      }
    end
  end
  
  @@stats = {
    :parsedVersions => Proc.new {|strVersionList| strVersionList.find_all{ |x| !x.nil? } },
  }
  @@metrics = {
    :numberOfUniqueValues => Proc.new {|strVersionList, method| 
      strVersionList.map{|strVersion| 
        VersionNumber.new(strVersion).getCompoundById(method)
      }.uniq.length 
    },
    :uniqueValues => Proc.new {|strVersionList, method| 
      strVersionList.map{|strVersion| 
        VersionNumber.new(strVersion).getCompoundById(method)
      }.uniq
    },
    :numberOfEmptyValues => Proc.new {|strVersionList, method| 
      strVersionList.map{|strVersion| 
        VersionNumber.new(strVersion).getCompoundById(method)
      }.find_all{|i| i == ''}.length
    },
    :distributionOfUniqueValues => Proc.new {|strVersionList, method| 
      strVersionList.map{|strVersion| 
        VersionNumber.new(strVersion).getCompoundById(method)
      }.uniq.map { |uniq| 
        { uniq => ((strVersionList.find_all{ |i| i == uniq }.length.to_f/strVersionList.length*100).round(2)).to_s + "%" }
    }.reduce Hash.new, :merge },
  }
  
  def getVersions
    @releaseHistory
  end
  
  def getMegalomaniaSeverities
    @versionInconsistencies.megalomaniaSeverities
  end
  
  def getMegalomaniaSeverityPairs
    @versionInconsistencies.megalomaniaSeverityPairs
  end
  
  def getCycleLengths(compoundId)
    indexCount = 1
    cycleLengths = []
    @releaseHistory.each_with_index{|strVersion, i|
      if i != 0
        strVersion1 = @releaseHistory[i-1]
        strVersion2 = @releaseHistory[i]
        version1 = VersionNumber.new(strVersion1)
        version2 = VersionNumber.new(strVersion2)
        compound1 = version1.getCompoundById(compoundId) 
        compound2 = version2.getCompoundById(compoundId) 
        severity = @versionInconsistencies.versionMegalomaniaSeverity(version1, version2)
        if compound1 != compound2 || compound2.nil? || severity != 0
          cycleLengths << indexCount
          indexCount = 0
        end
        indexCount += 1
      end
    }
    cycleLengths << indexCount
    cycleLengths
  end
  
  def_each @@stats.keys do |method_name|
    if !@releaseHistory.nil? 
      @@stats[method_name].call(@releaseHistory)
    end
  end
  
  def_each @@metrics.keys do |metric_method|
    if !@releaseHistory.nil? 
      VersionNumber.versionCompoundMethods.map { |method_name,id| 
        @@metrics[metric_method].call(@releaseHistory, method_name)
      }
    end 
  end
  
end

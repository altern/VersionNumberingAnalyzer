# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'release_histories'
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
  
  attr_accessor :project, :version, :releaseHistory, :releaseHistories, :versionPattern
  
  def initialize(project = nil)
    @versionPattern = /^(\D*)?(\d+)([\._\s]([\dx]+))?([\._]([\dx]+))?([\._]([\dx]+))?([\._]([\dx]+))?(([-_\.\s]?(([a-zA-Z]*)[-_\s]?(\d*)))?(.*)?)?$/
    @releaseHistories = ReleaseHistories.new.releaseHistories
    @project = project
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
  
  def versionCompoundMethods 
    @@versionCompoundMethods 
  end
  
  def self.versionCompoundMethods 
    @@versionCompoundMethods 
  end
  
  @@stats = {
    :parsedVersions => Proc.new {|arr| arr.find_all{ |x| !x.nil? } },
  }
  @@metrics = {
    :numberOfUniqueValues => Proc.new {|arr| arr.uniq.length },
    :uniqueValues => Proc.new {|arr| arr.uniq},
    :numberOfEmptyValues => Proc.new {|arr| arr.find_all{|i| i == ''}.length},
    :distributionOfUniqueValues => Proc.new {|arr| arr.uniq.map { |uniq| 
      { uniq => ((arr.find_all{ |i| i == uniq}.length.to_f/arr.length*100).round(2)).to_s + "%" }
    }.reduce Hash.new, :merge },
  }
  
  def getIncrementMetrics
    vi = VersionInconsistencies.new
    @@versionCompoundMethods.each { |key, compoundId|
      compound = getCompoundById(compoundId)
      compound.each_with_index { |value, i|
        if i != 0
          curr = try_to_i(compound[i])
#          version2 = getCompounds(i).fullVersion
          if curr == 'x'
            vi.incrementVersionPlaceholder
          end
          prev = try_to_i(compound[i-1])
#          version1 = getCompounds(i-1).fullVersion
          if curr.nil? ^ prev.nil?
            vi.incrementEmptyJump(compoundId)
          elsif !curr.nil? && !prev.nil?
            if (curr - prev == 1) then
              vi.incrementVersionCompound(compoundId)
            elsif (curr - prev >= 2 )
              vi.incrementJump(compoundId)
#              vi.addJumpPair(compoundId, version1, version2)
            elsif curr < prev 
              if curr > 0
                vi.incrementJump(compoundId)
              end
            end
          end
        end
      }
    }
    if !@project.nil?
      releaseHistory = @releaseHistories[@project]
      releaseHistory.each_with_index { |value,i| 
        if i != 0 
          version1 = releaseHistory[i-1]
          version2 = releaseHistory[i]
          
          severity = vi.versionMegalomaniaSeverity(version1, version2)
          if (severity != 0)
            vi.addMegalomaniaSeverity(severity)
            vi.addMegalomaniaSeverityPair(version1, version2)
          end
          
#          parsedVersion1 = Version.new(version1)
#          parsedVersion2 = Version.new(version2)
#          
        end
      }
    elsif !@releaseHistory.nil? 
      @releaseHistory.each_with_index { |value,i| 
        if i != 0 
          version1 = @releaseHistory[i-1]
          version2 = @releaseHistory[i]
          severity = vi.versionMegalomaniaSeverity(VersionNumber.new(version1), VersionNumber.new(version2))
          if (severity != 0)
            vi.addMegalomaniaSeverity(severity)
            vi.addMegalomaniaSeverityPair(version1, version2)
          end
        end
      }
    end
    vi
  end
  
  def getMegalomaniaSeverities
    getIncrementMetrics.megalomaniaSeverities
  end
  
  def getMegalomaniaSeverityPairs
    getIncrementMetrics.megalomaniaSeverityPairs
  end
  
  def version(version = nil) 
    @version = version
  end
  
  def_each @@versionCompoundMethods.keys do |method_name|
    getCompoundById(@@versionCompoundMethods[method_name])
  end
  
  def_each @@stats.keys do |method_name|
    if !@releaseHistory.nil? 
      @@stats[method_name].call(@releaseHistory)
    end
  end
  
  def_each @@metrics.keys do |metric_method|
    @@versionCompoundMethods.map { |method_name,id| 
#      method_name.to_s + " => " + @@metrics[metric_method].call(getCompounds.map{|row| row[id]}).to_s
      @@metrics[metric_method].call(getCompounds.map{|row| row[id] unless row.nil?})
    }
  end
  
  def getCompounds 
    if !@project.nil?
      @releaseHistories[@project].map { |item| 
        matches = @versionPattern.match(item) 
        if !matches.nil? then
          @@versionCompoundMethods.map{|method,id| matches[id]}
        end
      }
    elsif !@releaseHistory.nil? 
      @releaseHistory.map { |item| 
        matches = @versionPattern.match(item) 
        if !matches.nil? then
          @@versionCompoundMethods.map{|method,id| matches[id]}
        end
      }
    elsif !@version.nil?
      @versionPattern.match(@version)
    end 
  end
  
  def getCompoundById id
    if !@version.nil? then
      matches = @versionPattern.match(@version) 
      if !matches.nil? then
        matches[id]
      end
    elsif !@project.nil?
      @releaseHistories[@project].map { |item| 
        matches = @versionPattern.match(item) 
        if !matches.nil?
          matches[id]
        end
      }
    elsif !@releaseHistory.nil? 
      @releaseHistory.map { |version|
        matches = @versionPattern.match(version)
        if !matches.nil? 
          matches[id]
        end
      }
    else
      @releaseHistories.map { |key, versions| 
        versions.map { |version|
          matches = @versionPattern.match(version)
          if !matches.nil? 
            matches[id]
          end
        } 
      }.flatten
    end
  end
  
end

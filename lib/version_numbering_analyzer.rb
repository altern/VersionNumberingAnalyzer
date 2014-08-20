# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'release_histories'

class Class
 def def_each(method_names, &block)
   method_names.each do |method_name|
     define_method method_name do
        instance_exec method_name, &block
     end
   end
 end
end

class VersionNumberingAnalyzer
  
  attr_accessor :project, :version, :releaseHistory, :releaseHistories, :versionPattern
  
  def initialize(project = nil)
    @versionPattern = /^(\D*)?(\d+)(\.(\d+))?(\.(\d+))?(\.(\d+))?(\.(\d+))?((-?((\D*)(\d*)))?(\D*)?)?$/
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
  }
  
  def versionCompoundMethods 
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
      @@metrics[metric_method].call(getCompounds.map{|row| row[id]})
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
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require_relative "version_numbering_analyzer"
require 'utils'

vna = VersionNumberingAnalyzer.new
#vna.version = "1.2.9"
#puts vna.fullVersion
#puts vna.getCompounds
#puts vna.fullSuffix
#vna.releaseHistory = Utils.readFileToArray('../test/git_release_history.txt')

#puts "Compounds:"
#puts vna.getCompounds.map{|matches| matches.each_with_index.map { |item,i| i.to_s + ": " + item.to_s }.join(', ')}
#puts ""
#puts "Number of unique values: "
#vna.versionCompoundMethods.each { |key,value| 
#  puts key.to_s + " => " + vna.numberOfUniqueValues[value].to_s
#}
#puts ""
#puts "Unique values: "
#vna.versionCompoundMethods.each { |key,value| 
#  puts key.to_s + " => " + vna.uniqueValues[value].to_s
#}
#puts ""
#puts "Number of empty values: "
#vna.versionCompoundMethods.each { |key,value| 
#  puts key.to_s + " => " + vna.numberOfEmptyValues[value].to_s
#}
#puts ""
#puts "Distribution of unique values: "
#vna.versionCompoundMethods.each { |key,value| 
#  puts key.to_s + " => " + vna.distributionOfUniqueValues[value].to_s
#}

#puts vna.uniqueValues[vna.versionCompoundMethods[:firstVersionCompound]]
#puts vna.getCompounds.map{ |row| row[2] }
#puts "full version => " + vna.getCompoundById(vna.versionCompoundMethods[:fullVersion]).join("\n")
#puts "first version compounds => " + vna.getCompoundById(vna.versionCompoundMethods[:firstVersionCompound]).join(',')
#puts "second version compounds => " + vna.getCompoundById(vna.versionCompoundMethods[:secondVersionCompound]).join(',')
#
#puts "increments =>" 
#vna.versionCompoundMethods.map{ |key, value|
#  if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#    puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.increments(value).to_s
#  end
#}
#puts "cycles =>" 
#vna.versionCompoundMethods.map{ |key, value|
#  if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#    puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.cycles(value).to_s
#  end
#}
#
#puts "jumps =>" 
#vna.versionCompoundMethods.map{ |key, value|
#  if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#    puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.jumps(value).to_s
#  end
#}
#puts "emptyJumps =>" 
#vna.versionCompoundMethods.map{ |key, value|
#  if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#    puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.emptyJumps(value).to_s
#  end
#}
#puts "cycleLengths =>" 
#vna.versionCompoundMethods.map{ |key, value|
#  if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#    puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.cycleLengths(value).to_s
#  end
#}

#vna.releaseHistory = ['1.0','1.1','1.2', '1.3', '2.0', '2.1']
#puts vna.getIncrementMetrics.cycleLengths[vna.versionCompoundMethods[:firstVersionCompound]]
#puts vna.getIncrementMetrics.cycleLengths[vna.versionCompoundMethods[:secondVersionCompound]]

Dir.glob('../data/COPEWeb_release_history.txt').select {|f| !File.directory? f}.each { |file|
  vna.releaseHistory = Utils.readFileToArray('../data/' + file)
  puts "===#{file}==="
  puts vna.fullVersion
  puts "increments =>" 
  vna.versionCompoundMethods.map{ |key, value|
    if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
      puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.increments(value).to_s
    end
  }
  
#  puts "cycles =>" 
#  vna.versionCompoundMethods.map{ |key, value|
#    if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#      puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.cycles(value).to_s
#    end
#  }
  
  puts "jumps =>" 
  vna.versionCompoundMethods.map{ |key, value|
    if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
      puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.jumps(value).to_s
    end
  }
  puts "emptyJumps =>" 
  vna.versionCompoundMethods.map{ |key, value|
    if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
      puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.emptyJumps(value).to_s
    end
  }
#  puts "cycleLengths =>" 
#  vna.versionCompoundMethods.map{ |key, value|
#    if [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].include? key
#      puts "\t" + key.to_s + " => " + vna.getIncrementMetrics.cycleLengths(value).to_s
#    end
#  }
  puts "**Parsed versions** "
  puts "\t" + vna.parsedVersions.to_s
  puts ""
  
  puts "**Number of unique values** "
  vna.versionCompoundMethods.each { |key,value| 
    puts "\t" + key.to_s + " => " + vna.numberOfUniqueValues[value].to_s
  }
  puts ""
  
  puts "**Unique values**"
  vna.versionCompoundMethods.each { |key,value| 
    puts "\t" + key.to_s + " => " + vna.uniqueValues[value].to_s
  }
  puts ""
  puts "**Number of empty values**"
  vna.versionCompoundMethods.each { |key,value| 
    puts "\t" + key.to_s + " => " + vna.numberOfEmptyValues[value].to_s
  }
  puts ""
  puts "**Distribution of unique values**"
  vna.versionCompoundMethods.each { |key,value| 
    puts "\t" + key.to_s + " => " + vna.distributionOfUniqueValues[value].to_s
  }
  puts ""
}
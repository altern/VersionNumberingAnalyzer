# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require_relative "version_numbering_analyzer"
require 'utils'

vna = VersionNumberingAnalyzer.new('git')
#vna.version = "1.2.9"
#puts vna.fullVersion
#puts vna.getCompounds
#puts vna.fullSuffix
vna.releaseHistory = Utils.readFileToArray('../test/git_release_history.txt')

puts "Compounds:"
puts vna.getCompounds.map{|matches| matches.each_with_index.map { |item,i| i.to_s + ": " + item.to_s }.join(', ')}
puts ""
puts "Number of unique values: "
vna.versionCompoundMethods.each { |key,value| 
  puts key.to_s + " => " + vna.numberOfUniqueValues[value].to_s
}
puts ""
puts "Unique values: "
vna.versionCompoundMethods.each { |key,value| 
  puts key.to_s + " => " + vna.uniqueValues[value].to_s
}
puts ""
puts "Number of empty values: "
vna.versionCompoundMethods.each { |key,value| 
  puts key.to_s + " => " + vna.numberOfEmptyValues[value].to_s
}
puts ""
puts "Distribution of unique values: "
vna.versionCompoundMethods.each { |key,value| 
  puts key.to_s + " => " + vna.distributionOfUniqueValues[value].to_s
}

puts vna.uniqueValues[vna.versionCompoundMethods[:firstVersionCompound]]
#puts vna.getCompounds.map{ |row| row[2] }
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require "version_numbering_analyzer"
require 'csv'
require 'utils'

# TODO: account for version history length : divide by number of unique version compound numbers


class CSVAggregator

  def initialize
    
    @headerColumns = {
      :projectName => 'Project name',
      :sourceType => 'Source type',
      :language => 'Language',
      :SDK => 'Development toolset',
      :teamSize => 'Team size',
      :age => 'Age',
      :source => 'Source',
      :link => 'Link',
      :appType => 'Application type',
      :appSize => 'Application size',
      :OS => 'Operating system'
    }
    
    @dataDir = '../data/'
    @projectInfoFilename = @dataDir + 'projects_metainfo.csv'
    @resultFilename = @dataDir + 'results.csv'
    
    @projectInfo = []
    
    CSV.foreach(File.path(@projectInfoFilename)) do |col|
      @projectInfo << @headerColumns.keys.each_with_index.map { |key,i| 
        { key.to_sym => col[i] }
      }.inject(:merge)
    end
    
    @metrics = {
      :firstVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :jumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]].length },
        :jumpsSum => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]].sum },
        :jumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:firstVersionCompound]].mean },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :emptyJumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]].length },
        :emptyJumpsSum => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]].uniq.sum },
        :emptyJumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:firstVersionCompound]].mean},
#        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :cycleLengthAverage => Proc.new{ |vna, projectName| 
#          puts "#{projectName} => "
#          puts "  avgCycleLength(1): #{vna.getCycleLengths(:firstVersionCompound).mean}"
#          puts "  avgCycleLength(2): #{vna.getCycleLengths(:secondVersionCompound).mean}"
#          puts "  avgCycleLength(3): #{vna.getCycleLengths(:thirdVersionCompound).mean}"
#          puts "  avgCycleLength(4): #{vna.getCycleLengths(:fourthVersionCompound).mean}"
#          puts "  avgCycleLength(5): #{vna.getCycleLengths(:suffixNumber).mean}"
          vna.getCycleLengths(:firstVersionCompound).mean
        },
      },
      :secondVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :jumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]].length },
        :jumpsSum => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]].sum },
        :jumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:secondVersionCompound]].mean },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :emptyJumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:secondVersionCompound]].length },
        :emptyJumpsSum => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:secondVersionCompound]].uniq.sum },
        :emptyJumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:secondVersionCompound]].mean },
#        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :cycleLengthAverage => Proc.new{ |vna| vna.getCycleLengths(:secondVersionCompound).mean},
      },
      :thirdVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :jumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].length },
        :jumpsSum => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].sum },
        :jumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].mean },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :emptyJumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].length },
        :emptyJumpsSum => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].uniq.sum },
        :emptyJumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:thirdVersionCompound]].mean },
#        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :cycleLengthAverage => Proc.new{ |vna| vna.getCycleLengths(:thirdVersionCompound).mean},
      },
      :fourthVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :jumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].length },
        :jumpsSum => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].sum },
        :jumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].mean },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :emptyJumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].length },
        :emptyJumpsSum => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].uniq.sum },
        :emptyJumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:fourthVersionCompound]].mean},
#        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :cycleLengthAverage => Proc.new{ |vna| vna.getCycleLengths(:fourthVersionCompound).mean},
      },
      :suffixNumber => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :jumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:suffixNumber]].length },
        :jumpsSum => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:suffixNumber]].sum },
        :jumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.jumpLengths[VersionNumber.versionCompoundMethods[:suffixNumber]].mean },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :emptyJumpsNumber => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:suffixNumber]].length },
        :emptyJumpsSum => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:suffixNumber]].uniq.sum },
        :emptyJumpsAverage => Proc.new{ |vna| vna.versionInconsistencies.emptyJumpValues[VersionNumber.versionCompoundMethods[:suffixNumber]].mean },
#        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :cycleLengthAverage => Proc.new{ |vna| vna.getCycleLengths(:suffixNumber).mean},
      },
      :megalomaniaSeverity => {
        :firstDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 2 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length} },
        :secondDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 3 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length} },
        :thirdDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 4 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length} },
        :fourthDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 5 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length} },
        :number => Proc.new{ |vna| 
          [:firstDegree, :secondDegree, :thirdDegree, :fourthDegree].each_with_index.map { |id,index| 
            # aggregatedMetric += @metrics[:megalomaniaSeverity][id].call(vna)*@metrics[id][:cycleLengthAverage].call(vna)
            metric = @metrics[:megalomaniaSeverity][id].call(vna)
            metric.empty? ? 0 : metric.length - 1 # *@metrics[mapping[id]][:cycleLengthAverage].call(vna)
          }.sum
        },
        :sum => Proc.new{ |vna| 
          [:firstDegree, :secondDegree, :thirdDegree, :fourthDegree].each_with_index.map { |id,index| 
            # aggregatedMetric += @metrics[:megalomaniaSeverity][id].call(vna)*@metrics[id][:cycleLengthAverage].call(vna)
            metric = @metrics[:megalomaniaSeverity][id].call(vna)
            metric.empty? ? 0 : (metric.length - 1)*(index+1) 
          }.sum
        },
        :average => Proc.new{ |vna| 
          num = [:firstDegree, :secondDegree, :thirdDegree, :fourthDegree].each_with_index.map { |id,index| 
            # aggregatedMetric += @metrics[:megalomaniaSeverity][id].call(vna)*@metrics[id][:cycleLengthAverage].call(vna)
            metric = @metrics[:megalomaniaSeverity][id].call(vna)
            metric.empty? ? 0 : metric.length - 1 
          }.sum
          
          sum = [:firstDegree, :secondDegree, :thirdDegree, :fourthDegree].each_with_index.map { |id,index| 
            # aggregatedMetric += @metrics[:megalomaniaSeverity][id].call(vna)*@metrics[id][:cycleLengthAverage].call(vna)
            metric = @metrics[:megalomaniaSeverity][id].call(vna)
            metric.empty? ? 0 : (metric.length - 1)*(index+1) 
          }.sum
          num.zero? ? 0 : sum/num
        },
      },
      :aggregated => {
        :increments => Proc.new{ |vna| 
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].map { |compoundId| 
            @metrics[compoundId][:increments].call(vna)
          }.sum
        },
        :jumpsNumber => Proc.new{ |vna| 
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each_with_index.map { |compoundId, index| 
            numOfChoices = vna.lengthOfLongestVersion - index
            numOfChoices > 0 ? @metrics[compoundId][:jumpsNumber].call(vna)*numOfChoices : 0
          }.sum
        },
        :emptyJumpsNumber => Proc.new{ |vna| 
          lengthOfFirstVersion = VersionNumber.new(vna.getVersions[0]).numberOfCompounds
          metric = lengthOfFirstVersion
          metric += [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].map { |compoundId| 
            @metrics[compoundId][:emptyJumps].call(vna)
          }.inject(:+).uniq.sum 
          metric.zero? ? 0 : metric - lengthOfFirstVersion
#          metric
        },
#        :versionPlaceholders => Proc.new{ |vna| 
#          aggregatedMetric = 0
#          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
#            aggregatedMetric += @metrics[compoundId][:versionPlaceholders].call(vna)*@metrics[compoundId][:cycleLengthAverage].call(vna)
#          }
#          aggregatedMetric
#        },
        :cycleLengthAverage => Proc.new{ |vna| 
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].map { |compoundId| 
            @metrics[compoundId][:cycleLengthAverage].call(vna)
          }.mean
        },
      },
      :aggregatedInconsistencyScore => Proc.new{ |vna| 0 }
    }
  end
  
def generateCSV
  CSV.open(@resultFilename, 'w') do |csv_object|
    header = @headerColumns.values
    header += [
      'Number of versions'
    ]
    header += [
      '1st vc increments', 
      '2nd vc increments', 
      '3rd vc increments', 
      '4th vc increments', 
      'Suffix number increments'
    ]
    header += [
      '1st vc number of jumps', 
      '1st vc sum of jumps', 
      '1st vc avg of jumps', 
      '2nd vc number of jumps', 
      '2nd vc sum of jumps', 
      '2nd vc avg of jumps', 
      '3rd vc number of jumps', 
      '3rd vc sum of jumps', 
      '3rd vc avg of jumps', 
      '4th vc number of jumps', 
      '4th vc sum of jumps', 
      '4th vc avg of jumps', 
      'Suffix number of jumps',
      'Suffix sum of jumps',
      'Suffix avg of jumps'
    ]
    header += [
      '1st vc number of empty jumps', 
      '1st vc sum of empty jumps', 
      '1st vc avg of empty jumps', 
      '2nd vc number of empty jumps', 
      '2nd vc sum of empty jumps', 
      '2nd vc avg of empty jumps', 
      '3rd vc number of empty jumps', 
      '3rd vc sum of empty jumps', 
      '3rd vc avg of empty jumps', 
      '4th vc number of empty jumps', 
      '4th vc sum of empty jumps', 
      '4th vc avg of empty jumps', 
      'Suffix number of empty jumps', 
      'Suffix sum of empty jumps', 
      'Suffix avg of empty jumps'
    ]
#    header += ['1st version compound placeholders', '2nd version compound placeholders', '3rd version compound placeholders', 
#      '4th version compound placeholders', 'Suffix number placeholders']
    header += [
      '1st vc avg cycle length', 
      '2nd vc avg cycle length', 
      '3rd vc avg cycle length', 
      '4th vc avg cycle length', 
      'Suffix number avg cycle length'
    ]
    header += [
#      'Megalomania of 1st degree severity', 
#      'Megalomania of 2nd degree severity',
#      'Megalomania of 3rd degree severity', 
#      'Megalomania of 4th degree severity', 
      'Number of megalomania severities',
      'Sum of megalomania severities',
      'Average of megalomania severities'
    ]
    header += [
      'Aggregated increments', 
      'Aggregated jumps', 
      'Aggregated empty jumps', 
#      'Aggregated version placeholders', 
      'Aggregated cycle length',
      'Aggregated inconsistency score',
    ]
#    puts header.join(',')
    csv_object << header
    @projectInfo.each_with_index { |project,i|
      if i == 0 then next end
      projectName = project[:projectName]
      source = project[:source]
      puts "==#{projectName}=="
      file_name = "#{projectName}_release_history(#{source}).txt"
      file = @dataDir + file_name
      if !File.exist?(file) then 
        puts "  !!!File #{file_name} does not exist!!!"
        next
      else
        puts "Processing file #{file_name}..."
      end
      projectInfo = @projectInfo.find{|value| value[:projectName] == projectName}
#      puts projectInfo
      projectReleaseHistory = Utils.readFileToArray('../data/' + file)
      projectVersionNumberingAnalyzer = VersionNumberingAnalyzer.new(projectReleaseHistory)
      if !projectInfo.nil?
        projectData = [
          projectName, 
          projectInfo[:sourceType], 
          projectInfo[:language], 
          projectInfo[:SDK], 
          projectInfo[:teamSize],
          projectInfo[:age],
          source,
          projectInfo[:link],
          projectInfo[:appType],
          projectInfo[:appSize],
          projectInfo[:OS],
          projectVersionNumberingAnalyzer.getVersions.length,
#          projectInfo[:appSize],
          @metrics[:firstVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:increments].call(projectVersionNumberingAnalyzer),
          
          @metrics[:firstVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:jumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:jumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:secondVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:jumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:jumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:thirdVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:jumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:jumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:fourthVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:jumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:jumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:suffixNumber][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:jumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:jumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:firstVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:emptyJumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:emptyJumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:secondVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:emptyJumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:emptyJumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:thirdVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:emptyJumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:emptyJumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:fourthVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:emptyJumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:emptyJumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:suffixNumber][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:emptyJumpsSum].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:emptyJumpsAverage].call(projectVersionNumberingAnalyzer),
          
          @metrics[:firstVersionCompound][:cycleLengthAverage].call(projectVersionNumberingAnalyzer, projectName),
          @metrics[:secondVersionCompound][:cycleLengthAverage].call(projectVersionNumberingAnalyzer, projectName),
          @metrics[:thirdVersionCompound][:cycleLengthAverage].call(projectVersionNumberingAnalyzer, projectName),
          @metrics[:fourthVersionCompound][:cycleLengthAverage].call(projectVersionNumberingAnalyzer, projectName),
          @metrics[:suffixNumber][:cycleLengthAverage].call(projectVersionNumberingAnalyzer, projectName),

          @metrics[:megalomaniaSeverity][:number].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:sum].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:average].call(projectVersionNumberingAnalyzer),
          
          @metrics[:aggregated][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:jumpsNumber].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
#          @metrics[:aggregated][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:cycleLengthAverage].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:average].call(projectVersionNumberingAnalyzer) + @metrics[:aggregated][:jumpsNumber].call(projectVersionNumberingAnalyzer) + @metrics[:aggregated][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer),
        ]
#        puts projectData.join(',')
        csv_object << projectData
        puts "
          length of longest version => #{projectVersionNumberingAnalyzer.lengthOfLongestVersion}
          jumps 1 => #{@metrics[:firstVersionCompound][:jumps].call(projectVersionNumberingAnalyzer)}
          jumps 1 number => #{@metrics[:firstVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps 2 => #{@metrics[:secondVersionCompound][:jumps].call(projectVersionNumberingAnalyzer)}
          jumps 2 number => #{@metrics[:secondVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps 3 => #{@metrics[:thirdVersionCompound][:jumps].call(projectVersionNumberingAnalyzer)}
          jumps 3 number => #{@metrics[:thirdVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps 4 => #{@metrics[:fourthVersionCompound][:jumps].call(projectVersionNumberingAnalyzer)}
          jumps 4 number => #{@metrics[:fourthVersionCompound][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps 5 => #{@metrics[:suffixNumber][:jumps].call(projectVersionNumberingAnalyzer)}
          jumps 5 number => #{@metrics[:suffixNumber][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps aggregated number => #{@metrics[:aggregated][:jumpsNumber].call(projectVersionNumberingAnalyzer)}
          jumps 1 => #{@metrics[:firstVersionCompound][:jumps].call(projectVersionNumberingAnalyzer)}
          empty jumps 1 number => #{@metrics[:firstVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          empty jumps 2 => #{@metrics[:secondVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer)}
          empty jumps 2 number => #{@metrics[:secondVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          empty jumps 3 => #{@metrics[:thirdVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer)}
          empty jumps 3 number => #{@metrics[:thirdVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          empty jumps 4 => #{@metrics[:fourthVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer)}
          empty jumps 4 number => #{@metrics[:fourthVersionCompound][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          empty jumps 5 => #{@metrics[:suffixNumber][:emptyJumps].call(projectVersionNumberingAnalyzer)}
          empty jumps 5 number => #{@metrics[:suffixNumber][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          empty jumps aggregated number => #{@metrics[:aggregated][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)}
          megalomania number => #{@metrics[:megalomaniaSeverity][:number].call(projectVersionNumberingAnalyzer)}
          megalomania sum => #{@metrics[:megalomaniaSeverity][:sum].call(projectVersionNumberingAnalyzer)}
          megalomania average => #{@metrics[:megalomaniaSeverity][:average].call(projectVersionNumberingAnalyzer)}
          aggregated measure of inconsistency => #{
            @metrics[:megalomaniaSeverity][:average].call(projectVersionNumberingAnalyzer) + 
            @metrics[:aggregated][:jumpsNumber].call(projectVersionNumberingAnalyzer) +
            @metrics[:aggregated][:emptyJumpsNumber].call(projectVersionNumberingAnalyzer)
          }"
      end
    }
    puts "DONE!"
  end
end
end
  
csv = CSVAggregator.new
csv.generateCSV()

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
    
    @projectInfoFilename = '../data/projects_metainfo.csv'
    @resultFilename = '../data/results.csv'
    
    @projectInfo = []
    
    CSV.foreach(File.path(@projectInfoFilename)) do |col|
      @projectInfo << @headerColumns.keys.each_with_index.map { |key,i| 
        { key.to_sym => col[i] }
      }.inject(:merge)
    end
    
    @metrics = {
      :firstVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:firstVersionCompound]] },
        :averageCycleLength => Proc.new{ |vna, projectName| 
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
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:secondVersionCompound]] },
        :averageCycleLength => Proc.new{ |vna| vna.getCycleLengths(:secondVersionCompound).mean},
      },
      :thirdVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:thirdVersionCompound]] },
        :averageCycleLength => Proc.new{ |vna| vna.getCycleLengths(:thirdVersionCompound).mean},
      },
      :fourthVersionCompound => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:fourthVersionCompound]] },
        :averageCycleLength => Proc.new{ |vna| vna.getCycleLengths(:fourthVersionCompound).mean},
      },
      :suffixNumber => {
        :increments => Proc.new{ |vna| vna.versionInconsistencies.increments[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :jumps => Proc.new{ |vna| vna.versionInconsistencies.jumps[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :emptyJumps => Proc.new{ |vna| vna.versionInconsistencies.emptyJumps[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :versionPlaceholders => Proc.new{ |vna| vna.versionInconsistencies.versionPlaceholders[VersionNumber.versionCompoundMethods[:suffixNumber]] },
        :averageCycleLength => Proc.new{ |vna| vna.getCycleLengths(:suffixNumber).mean},
      },
      :megalomaniaSeverity => {
        :firstDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 2 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length}.mean },
        :secondDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 3 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length}.mean },
        :thirdDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 4 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length}.mean },
        :fourthDegree => Proc.new{ |vna| vna.getMegalomaniaSeverities.chunk { |x| x >= 5 }.reject{|sep,ans| sep}.map{|sep,ans| ans}.map{|arr| arr.length}.mean },
        :aggregated => Proc.new{ |vna| 
          aggregatedMetric = 0
          [:firstDegree, :secondDegree, :thirdDegree, :fourthDegree].each { |id| 
            # aggregatedMetric += @metrics[:megalomaniaSeverity][id].call(vna)*@metrics[id][:averageCycleLength].call(vna)
          }
          aggregatedMetric
        },
      },
      :aggregated => {
        :increments => Proc.new{ |vna| 
          aggregatedMetric = 0
          sum = 0
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
#            puts "  increments(#{compoundId.to_s}): " + @metrics[compoundId][:increments].call(vna).to_s
            sum += @metrics[compoundId][:increments].call(vna)
            aggregatedMetric += @metrics[compoundId][:increments].call(vna)*@metrics[compoundId][:averageCycleLength].call(vna)
          }
#          puts "  increments sum: " + sum.to_s
#          puts "  aggregated increments: " + aggregatedMetric.to_s
          aggregatedMetric
        },
        :jumps => Proc.new{ |vna| 
          aggregatedMetric = 0
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
            aggregatedMetric += @metrics[compoundId][:jumps].call(vna)*@metrics[compoundId][:averageCycleLength].call(vna)
          }
          aggregatedMetric
        },
        :emptyJumps => Proc.new{ |vna| 
          aggregatedMetric = 0
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
            aggregatedMetric += @metrics[compoundId][:emptyJumps].call(vna)*@metrics[compoundId][:averageCycleLength].call(vna)
          }
          aggregatedMetric
        },
        :versionPlaceholders => Proc.new{ |vna| 
          aggregatedMetric = 0
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
            aggregatedMetric += @metrics[compoundId][:versionPlaceholders].call(vna)*@metrics[compoundId][:averageCycleLength].call(vna)
          }
          aggregatedMetric
        },
        :averageCycleLength => Proc.new{ |vna| 
          aggregatedMetric = 0
          [:firstVersionCompound, :secondVersionCompound, :thirdVersionCompound, :fourthVersionCompound, :suffixNumber].each { |compoundId| 
            aggregatedMetric += @metrics[compoundId][:averageCycleLength].call(vna)*@metrics[compoundId][:averageCycleLength].call(vna)
          }
          aggregatedMetric
        },
      },
      :aggregatedInconsistencyScore => Proc.new{ |vna| 0 }
    }
  end
  
def generateCSV
  CSV.open(@resultFilename, 'w') do |csv_object|
    header = @headerColumns.values
    header += ['1st version compound increments', '2nd version compound increments', '3rd version compound increments', 
      '4th version compound increments', 'Suffix number jumps']
    header += ['1st version compound jumps', '2nd version compound jumps', '3rd version compound jumps', 
      '4th version compound jumps', 'Suffix number jumps']
    header += ['1st version compound empty jumps', '2nd version compound empty jumps', '3rd version compound empty jumps', 
      '4th version compound empty jumps', 'Suffix number empty jumps']
    header += ['1st version compound placeholders', '2nd version compound placeholders', '3rd version compound placeholders', 
      '4th version compound placeholders', 'Suffix number placeholders']
    header += ['1st version compound cycle length', '2nd version compound cycle length', '3rd version compound cycle length', 
      '4th version compound cycle length', 'Suffix number cycle length']
    header += ['Megalomania of 1st degree severity', 'Megalomania of 2nd degree severity', 'Megalomania of 3rd degree severity', 
      'Megalomania of 4th degree severity', 'Aggregated megalomania severity']
    header += ['Aggregated increments', 'Aggregated jumps', 'Aggregated empty jumps', 
      'Aggregated version placholders', 'Aggregated cycle length']
    puts header.join(',')
    csv_object << header
    Dir.glob('../data/*_release_history.txt').select {|f| !File.directory? f}.each { |file|
      projectName = file.split('_release_history.txt')[0].split('/')[-1]
#      puts projectName
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
          projectInfo[:source],
          projectInfo[:appType],
          projectInfo[:appSize],
#          projectInfo[:appSize],
          @metrics[:firstVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:firstVersionCompound][:averageCycleLength].call(projectVersionNumberingAnalyzer, projectName),
          @metrics[:secondVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:secondVersionCompound][:averageCycleLength].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:thirdVersionCompound][:averageCycleLength].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:fourthVersionCompound][:averageCycleLength].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:suffixNumber][:averageCycleLength].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:firstDegree].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:secondDegree].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:thirdDegree].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:fourthDegree].call(projectVersionNumberingAnalyzer),
          @metrics[:megalomaniaSeverity][:aggregated].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:increments].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:jumps].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:emptyJumps].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:versionPlaceholders].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregated][:averageCycleLength].call(projectVersionNumberingAnalyzer),
          @metrics[:aggregatedInconsistencyScore].call(projectVersionNumberingAnalyzer),
        ]
        puts projectData.join(',')
        csv_object << projectData
      end
    }
    puts "DONE!"
  end
end
end
  
csv = CSVAggregator.new
csv.generateCSV()

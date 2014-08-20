# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'version_numbering_analyzer'
require 'utils'

class VersionNumberingAnalyzerTest < Test::Unit::TestCase
  
  def setup
    @vna = VersionNumberingAnalyzer.new
    @vna.releaseHistory = Utils.readFileToArray('test/git_release_history.txt')
    @number_of_release_history_entiries = 486
  end
  
  def test_number_of_release_history_entries
    assert_equal(@number_of_release_history_entiries, @vna.releaseHistory.length)
  end
  
  def test_number_of_parsed_versions
    assert_equal(@number_of_release_history_entiries, @vna.parsedVersions.length)
  end
  
  def test_number_of_unique_values
    assert_equal(3, @vna.uniqueValues[@vna.versionCompoundMethods[:firstVersionCompound]].length)
    assert_equal(11, @vna.uniqueValues[@vna.versionCompoundMethods[:secondVersionCompound]].length)
    assert_equal(15, @vna.uniqueValues[@vna.versionCompoundMethods[:thirdVersionCompound]].length)
    assert_equal(10, @vna.uniqueValues[@vna.versionCompoundMethods[:fourthVersionCompound]].length)
    assert_equal(16, @vna.uniqueValues[@vna.versionCompoundMethods[:suffixLabel]].length)
    assert_equal(9, @vna.uniqueValues[@vna.versionCompoundMethods[:suffixNumber]].length)
  end
  
end

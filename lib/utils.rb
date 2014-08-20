#$:.unshift File.join(File.dirname(__FILE__),'..','lib')

class Utils
  def self.readFileToArray(file)
    arr = []
    File.foreach(file) do |line|
      arr << line
    end
    return arr
  end
end
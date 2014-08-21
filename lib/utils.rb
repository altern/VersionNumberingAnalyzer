#arr$:.unshift File.join(File.dirname(__FILE__),'..','lib')

class Utils
  def self.readFileToArray(file)
    arr = []
    File.foreach(file) do |line|
      arr << line.strip
    end
    return arr
  end
end
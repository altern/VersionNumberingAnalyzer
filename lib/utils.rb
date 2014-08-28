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

def try_to_i(str, default = nil)
  str =~ /^-?\d+$/ ? str.to_i : default
end

class Class
 def def_each(method_names, &block)
   method_names.each do |method_name|
     define_method method_name do
        instance_exec method_name, &block
     end
   end
 end
end

class Array
    def sum
      inject(0.0) { |result, el| result + el }
    end

    def mean 
      sum / size
    end
  end
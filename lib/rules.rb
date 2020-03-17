class Rule
  @@report = []

  attr_reader :name, :msg, :broken
  def initialize(name)
    @name = name
    @broken = false
  end

  def broken?
    @broken
  end 

  def parse(arr, name)
  end

  def self.give_report
    @@report
  end
end

class FileSize < Rule
  def parse(file_data, file_name)
    lines = file_data.count
    if lines > 5
      @broken = true
      @@report << "#{file_name} lines: #{lines}  #{@name}"
    end
  end
end
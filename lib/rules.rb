class Rule
  @@report = []
  attr_reader :name, :msg, :broken
  def initialize(name)
    @name = name
    @broken = false
    @line = 0
  end

  def broken?
    @broken
  end 

  def parse(arr, name)
  end

  def add_to_report(file_name, line, name, info)
    @@report << [file_name, line, name, info]
  end

  def self.give_report
    @@report.sort_by{|a ,b| a[1] <=> b[1] }
  end
end

class FileSize < Rule
  def parse(file_data, file_name)
    lines = file_data.count
    if lines > 3
      @broken = true
      add_to_report(file_name, @line, @name, lines)
    end
  end
  @broken
end

class MaxLineLength < Rule
  def parse(file_data, file_name)
    file_data.each do |code_line|
      @line += 1
      char_num = code_line.length
      if  char_num > 80
        @broken = true
        add_to_report(file_name, @line, @name, char_num)
      end
    end
  end
  @broken
end

class Indentation < Rule
  def parse(file_data, file_name)
    map = build_map(file_data)
    map = flag_different(map)
    map = discard_erroneous(map)
    map.each do |line|
      if line[3]
        add_to_report(file_name, line[0], @name, line[1])
        @broken = true
      end
    end
    @broken
  end

  def build_map(file_data)
    map = []
    file_data.each do |code_line|
      @line += 1
      map << [@line, indentation(code_line), guard_clause?(code_line), nil]
    end
    map
  end
  
  def indentation(line)
    indentation = 0
    line.split(//).each do |char|
      char == ' ' ? indentation += 1 : break 
    end
    indentation
  end

  def guard_clause?(line)
    line.include?('return') && (line.include?('if') || line.include?('unless'))
  end

  def unexpected?(former, current)
    current != former && current != former +2 && current != former -2
  end

  def flag_different(map)
    former = 0
    map.each do |line|
      line[3] = unexpected?(former, line[1])
      former = line[1] 
    end
    map
  end

  def discard_erroneous(map)
    map.each_with_index do |line, i|
      if line[3]
        if line[1] && map[i-1][2]
          line[3] = false
        end
        if map[i+1][3] && map[i-1][1] == map[i+1][1]
          map[i+1][3] = false
        end
      end
    end
  end

end
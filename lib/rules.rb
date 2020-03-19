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

  def parse(arr, name); end

  def add_to_report(file_name, line, name, info)
    @@report << [file_name, line, name, info]
  end

  def self.give_report
    @@report.sort_by { |a, b| a[1] <=> b[1] }
  end
end

class FileSize < Rule
  def parse(file_data, file_name)
    @line = 0
    data = file_data.map(&:chomp)
    lines = data.count
    if lines > 100
      @broken = true
      add_to_report(file_name, @line, @name, lines)
    else
      @broken = false
    end
    @broken
  end
end

class MaxLineLength < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    @line = 0
    @broken = false
    data.each do |code_line|
      @line += 1
      char_num = code_line.length
      if char_num > 80
        @broken = true
        add_to_report(file_name, @line, @name, char_num)
      end
    end
    @broken
  end
end

class Indentation < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    map = build_map(data)
    map = flag_different(map)
    map = discard_erroneous(map)
    @line = 0
    @broken = false
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
    @line = 0
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
    current != former && current != former + 2 && current != former - 2
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
    num_lines = map.count
    map.each_with_index do |line, i|
      next unless line[3]
      line[3] = false if line[1] && map[i-1][2]
      map[i + 1][3] = false if i < num_lines - 1 && map[i + 1][3] && map[i - 1][1] == map[i + 1][1]
    end
  end
end

class TrailingWhiteSpace < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    @line = 0
    @broken = false
    data.each do |code_line|
      @line += 1
      chars = code_line.split(//)
      if chars.last == ' '
        @broken = true
        add_to_report( file_name, @line, @name, nil )
      end
    end
    @broken
  end
end

class EmptyEOFLine < Rule
  def parse(file_data, file_name)
    @broken = false
    code_line = file_data.last.nil? ? '' : file_data.last
    chars = code_line.split(//)
    last = chars.last
    unless last =~ /\n/
      add_to_report(file_name, 0, @name, nil)
      @broken = true
    end
    @broken
  end
end

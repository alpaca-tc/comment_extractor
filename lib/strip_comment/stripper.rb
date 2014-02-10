class CommentParser::Stripper
  attr_accessor :configuration

  def initialize(options = {})
    @configuration = CommentParser::Configuration.new(options)
    yield(@configuration) if block_given?
  end

  def comments
    list_up_files.each_with_object([]) do |file, memo|
      file = CommentParser::FileObject.new(file)
      parser = CommentParser::Parser.for(file)
      memo.concat(parser.scan) if parser
    end
  end

  private

  def list_up_files
    @files ||= begin
      root_path = configuration.root_path
      root_path = File.dirname(root_path) unless File.directory?(root_path)
      Dir["#{root_path}/**/*"]
    end.select { |v| enabled_file?(v) }
  end

  def enabled_file?(file_path)
    # [review] - Complex branch function...
    if File.directory?(file_path) || ignore_file?(file_path)
      false
    elsif configuration.directories.empty? && configuration.files.empty?
      true
    elsif !configuration.directories.empty? && configuration.files.empty?
      directories_contained?(file_path)
    elsif configuration.directories.empty? && !configuration.files.empty?
      files_contained?(file_path)
    else
      directories_contained?(file_path) && files_contained?(file_path)
    end
  end

  def files_contained?(file_path)
    # [todo] - Checking files at most one
    configuration.files.each do |pattern|
      return true if Regexp.new(pattern) =~ file_path
    end

    false
  end

  def directories_contained?(file_path)
    # [todo] - Checking directories at most one
    configuration.directories.each do |pattern|
      return true if Regexp.new(pattern) =~ file_path
    end

    false
  end

  def ignore_file?(file_path)
    # [todo] - Checking ignore_list at most one
    configuration.ignore_list.each do |pattern|
      return true if Regexp.new(pattern) =~ file_path
    end

    false
  end
end

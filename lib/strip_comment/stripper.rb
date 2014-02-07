class StripComment::Stripper
  attr_accessor :configuration

  def initialize(options = {})
    @configuration = StripComment::Configuration.new(options)
    yield(@configuration) if block_given?
  end

  def list_up_files
    # [todo] - files, directriesの実装
    root_path = configuration.root_path
    root_path = File.dirname(root_path) unless File.directory?(root_path)

    Dir["#{root_path}/**/*"].select { |v| enabled_file?(v) }
  end

  def comments
    list_up_files.each_with_object([]) do |file, memo|
      file = StripComment::FileObject.new(file)
      parser = StripComment::Parser.for(file)
      memo.concat(parser.scan) if parser
    end
  end

  private

  def enabled_file?(file_path)
    return false if File.directory?(file_path)

    configuration.ignore_list.each do |regexp|
      return false if regexp =~ file_path
    end

    true
  end
end

class StripComment::Stripper
  attr_accessor :configuration

  def initialize(options = {})
    @configuration = StripComment::Configuration.new(options)
    yield(@configuration) if block_given?
  end

  def list_up_files
    root_path = configuration.root_path
    root_path = File.dirname(root_path) unless File.directory?(root_path)

    # [todo] - exceptを実装
    # [todo] - 非同期を実装
    Dir["#{root_path}/**/*"].each_with_object([]) do |path, memo|
      memo << path unless File.directory?(path)
    end
  end

  def comments
    list_up_files.each_with_object([]) do |file, memo|
      file = StripComment::FileObject.new(file)
      parser = StripComment::Parser.for(file)
      memo.concat(parser.scan) if parser
    end
  end
end

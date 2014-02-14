require 'tempfile'

module CommentExtractor::Encoding
  def self.read_file(file_path, encoding = Encoding.default_external)
    content = File.open(file_path, 'rb') { |f| f.read }
    self.encode(content)
  end

  def self.encode(content, encoding = Encoding.default_external)
    windows_platforms = Regexp.new(%w[mingw mswin].join('|'))
    content.gsub!("\r\n", "\n") if RUBY_PLATFORM =~ windows_platforms

    original_encoding = content.encoding

    if strip_bom(content) # When content is UTF-8
      content.force_encoding(Encoding::UTF_8)
      content.encode!(encoding)
    else
      content.force_encoding(encoding)
    end

    unless content.valid_encoding?
      content.force_encoding(original_encoding)
      content.encode!(encoding)
    end

    unless content.valid_encoding?
      raise "Unable to convert #{file_path} to #{encoding}"
    end

    content
  # rescue Encoding::InvalidByteSequenceError, Encoding::UndefinedConversionError => e
  #   nil
  # rescue Errno::EISDIR, Errno::ENOENT
  #   nil
  # rescue ArgumentError => e
  #   nil
  end

  private

  def self.strip_bom(content)
    bom_regexp = /\A\xef\xbb\xbf/
    content.sub!(bom_regexp, '')
  end
end

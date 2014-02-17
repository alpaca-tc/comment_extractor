module CommentExtractor
  module Encoding
    def self.read_file(file_path, encoding = ::Encoding.default_external)
      content = File.open(file_path, 'rb') { |f| f.read }
      self.encode(content)
    end

    def self.encode(content, encoding = ::Encoding.default_external)
      windows_platforms = Regexp.new(%w[mingw mswin].join('|'))
      content.gsub!("\r\n", "\n") if RUBY_PLATFORM =~ windows_platforms

      original_encoding = content.encoding

      if strip_bom(content) # When the content contains bom, it is UTF-8
        content.force_encoding(::Encoding::UTF_8)
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
    end

    private

    def self.strip_bom(content)
      bom_regexp = /\A\xef\xbb\xbf/
      content.sub!(bom_regexp, '')
    end
  end
end

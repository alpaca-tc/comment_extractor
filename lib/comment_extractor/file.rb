require 'comment_extractor/encoding'

module CommentExtractor
  class File < ::File
    THRESHOLD_BINARY = 0.3

    attr_accessor :content, :shebang

    def self.shebang(path)
      if File.extname(path).empty?
        line = File.open(path) { |f| f.gets }
        if /\A#!\s*(?<shebang_path>.+)/ =~ line
          shebang_path
        end
      end
    end

    def self.binary?(file_path)
      header = File.read(file_path, File.stat(file_path).blksize) || nil

      if header.nil? || header.empty?
        false
      else
        chars = header.chars
        (chars.grep(' '..'~').size / chars.size.to_f) <= THRESHOLD_BINARY
      end
    end

    def read_content
      return if File.binary?(self.path)

      if File.shebang(self.path)
        self.gets # Remove shebang
      end

      CommentExtractor::Encoding.encode(self.read)
    end
  end
end

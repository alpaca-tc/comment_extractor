require 'comment_extractor/encoding'

module CommentExtractor
  class File < ::File
    THRESHOLD_BINARY = 0.3
    BINARY_EXTENSIONS = Hash[%w(.flv .swf .png .jpg .gif .asx .zip .rar .tar .7z .gz .jar .js .css .dtd .xsd .ico .raw .mp3 .mp4 .wav .wmv .ape .aac .ac3 .wma .aiff .mpg .mpeg .avi .mov .ogg .mkv .mka .asx .asf .mp2 .m1v .m3u .f4v .pdf .doc .xls .ppt .pps .bin .exe .rss .xml).zip]

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
      extname = File.extname(file_path)

      if extname.empty?
        header = File.read(file_path, File.stat(file_path).blksize) || nil

        if header.nil? || header.empty?
          false
        else
          chars = header.chars
          (chars.grep(' '..'~').size / chars.size.to_f) <= THRESHOLD_BINARY
        end
      else
        BINARY_EXTENSIONS.has_key?(extname)
      end
    end

    def read_content
      return if File.binary?(self.path)

      if File.shebang(self.path)
        self.gets # Remove shebang
      end

      CommentExtractor::Encoding.encode(self.read) || ''
    end
  end
end

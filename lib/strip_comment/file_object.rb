require 'delegate'

class StripComment::FileObject < File
  THRESHOLD_BINARY = 0.3

  attr_accessor :content, :shebang

  def binary?
    header = File.read(self.path, File.stat(self.path).blksize) || nil

    if header.empty?
      return false
    else
      chars = header.chars
      (chars.grep(' '..'~').size / chars.size.to_f) <= THRESHOLD_BINARY
    end
  end

  def shebang
    @shebang ||= begin
      line =  File.open(self.path) { |f| f.gets }
      extname = File.extname(self.path)

      if extname.empty? && /\A#!\s*(?<shebang_path>.+)/ =~ line
        shebang_path
      end
    end
  end

  def content
    @content ||= begin
      if shebang
        self.gets # Removes shebang
      end

      self.read
    end
  end
end

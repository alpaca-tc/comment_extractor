require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Text < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.txt$/
  filetype 'text'

  def scan
    count = 0
    until scanner.eos?
      scanner.scan(/\n/)
      line = scanner.scan(/^.*$/)
      if /#(?<comment>.*)/ =~ line
        code_objects << build_comment(count, comment, {})
      end

      count += 0
    end
  end
end

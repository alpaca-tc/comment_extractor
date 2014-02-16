require 'comment_extractor/file'

using CommentExtractor::DetectableSchemeFile

class CommentExtractor::Parser
  def initialize(scanner)
    @scanner = scanner
  end

  def parse
    @scanner.scan
    @scanner.comments
  end
end

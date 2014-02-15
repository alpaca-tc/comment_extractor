# Copyright (c) 2006-2009 Hampton Catlin and Nathan Weizenbaum and @alpaca-tc
require 'haml'
class CommentExtractor::Extractor::Haml < CommentExtractor::Extractor
  filename /\.haml$/
  filetype 'haml'

  # [review] - incompleted method
  def extract_comments
    options = ::Haml::Options.new
    parser = ::Haml::Parser.new(self.content, options)
    parsered = parser.parse
    parsered.children.each do |node|
      detect_comment_from_node(node)
    end
    self.comments
  end

  private

  def detect_comment_from_node(node)
    case node.type
    when :haml_comment
      identify_single_line_comment_from_comment_tag(node)
    when :tag, :script
      identify_single_line_comment_from_tag(node)
    end

    node.children.each do |child|
      detect_comment_from_node(child)
    end
  end

  def identify_single_line_comment_from_tag(node)
    # [todo] - refactoring
    if /#(?<comment>[^#]*)$/ =~ (node.value[:text])
      add_comment(node.line, comment) unless comment.empty?
    end

    if /#(?<comment>[^#]*)$/ =~ node.value[:value]
      add_comment(node.line, comment) unless comment.empty?
    end
  end

  def identify_single_line_comment_from_comment_tag(node)
    add_comment(node.line, node.value[:text])  unless node.value[:text].empty?
  end
end

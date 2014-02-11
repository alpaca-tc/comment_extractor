class CommentParser::Scanner::JavaScript < CommentParser::Scanner
  filename /\.js$/
  filetype 'javascript'
  shebang /.*(js|node)$/

  def scan
    corrective_line = self.file_object.shebang ? 1 : 0
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(/"/)
        scanner.scan(/.+?(?<!\\)"/m)
      when scanner.scan(/'/)
        scanner.scan(/.+?(?<!\\)'/m)
      when scanner.scan(%r!/!)
        case
        when scanner.scan(/\*/)
          identify_multi_comment
        when scanner.scan(%r!/!)
          identify_single_comment
        else
          scanner.scan(%r!.*?/!)
        end
      when scanner.scan(/(\w|\W)/)
        next
      when scanner.scan(CommentParser::Scanner::REGEXP[:BREAK])
        next
      else
        raise_report
      end
    end
  end

  private

  def identify_single_comment
    line_no = current_line
    line = build_scanner.scan(/.*$/).strip
    add_comment(line_no, line, { type: :singleline })
  end

  def identify_multi_comment
    line_no = current_line
    lines = build_scanner.scan(/.*?\*\//m).sub(/\*\/$/, '').split("\n")
    lines.each_with_index do |line, index|
      line.strip!
      if lines.size != (index + 1) || line !~ /^\s*$/
        add_comment(line_no + index, line, { type: :multiline })
      end
    end
  end
end

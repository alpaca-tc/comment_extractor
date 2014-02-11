class CommentParser::Scanner::Clojure < CommentParser::Scanner
  disable!
  filename /\.clj$/
  filetype 'clojure'

  def scan
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(/"/)
        scanner.scan(/.*?(?<!\\)"/m)
      when scanner.scan(/'/)
        scanner.scan(/.*?(?<!\\)'/m)
      when scanner.scan(%r!;+!)
        identify_single_comment
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
end

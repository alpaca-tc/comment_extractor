class CommentParser::Scanner::Haskell < CommentParser::Scanner
  filename /\.hs$/
  filetype 'haskell'

  def scan
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(/"/)
        scanner.scan(/.*?(?<!\\)"/m)
      when scanner.scan(/'/)
        scanner.scan(/.*?(?<!\\)'/m)
      when scanner.scan(%r!--!)
        identify_single_line_comment
      when scanner.scan(%r!{-!)
        identify_multi_line_comment
      when scanner.scan(/(\w|\W)/)
        next
      when scanner.scan(CommentParser::Scanner::REGEXP[:BREAK])
        next
      end
    end
  end

  private

  def identify_single_line_comment
    scanner = build_scanner
    line_no = current_line
    comment = scanner.scan(/^.*$/)
    add_comment(line_no, comment)
  end

  def identify_multi_line_comment
    scanner = build_scanner
    line_no = current_line
    comments = scanner.scan(/.*?-}/m).sub(/-}$/, '').split("\n")
    comments.each_with_index do |comment, index|
      add_comment(line_no + index, comment)
    end
  end
end

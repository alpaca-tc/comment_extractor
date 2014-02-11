class CommentParser::Scanner::Coffee < CommentParser::Scanner
  disable!
  filename /\.coffee$/
  filetype 'coffee'

  def scan
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(/"/)
        scanner.scan(/.*?(?<!\\)"/m)
      when scanner.scan(/'/)
        scanner.scan(/.*?(?<!\\)'/m)
      when scanner.scan(%r!///!)
        scan_multi_line_regexp
      when scanner.scan(%r!/!)
        scanner.scan(/.*?(?<!\\)\//m)
      when scanner.scan(%r!#!)
        case
        when scanner.scan(/##/)
          identify_multi_line_comment
        else
          identify_single_line_comment
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

  def scan_multi_line_regexp
    line_no = current_line + 1
    lines = build_scanner.scan(/.*?(?<!\\)\/\/\//m).sub(%r!///!, '').split("\n")
    lines.each.with_index do |line, index|
      if /(?<!\[)#(?<comment>.*)$/ =~ line
        comment.strip!
        add_comment(line_no + index - 1, comment, { type: :multi_line })
      end
    end
  end

  def identify_multi_line_comment
    line_no = current_line
    lines = build_scanner.scan(/.*###/m).sub(/###\s*$/, '').strip.split("\n")
    lines.each_with_index do |line, index|
      line.strip!
      if lines.size != (index + 1) || line !~ /^\s*$/
        add_comment(line_no + index, line, { type: :singleline })
      end
    end
  end

  def identify_single_line_comment
    line_no = current_line
    binding.pry if line_no == 14
    line = build_scanner.scan(/.*$/).strip
    add_comment(line_no, line, { type: :singleline })
  end
end

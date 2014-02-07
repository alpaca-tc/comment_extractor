module StripComment::Scanner::Concerns::SlashScanner
  def scan
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(StripComment::Scanner::REGEXP[:BREAK]), scanner.scan(%r!^\s*$!)
        next
      when scanner.scan(%r!\s*//!)
        scan_oneline_comment
      when scanner.scan(%r!\s*/\*!)
        scan_multi_comment
      when scanner.scan(%r![0-9a-zA-Z()\[\]\?\!.,:;'"~#@`{}= /_\'"&+|<>*&%\\-]!)
        # [review] - Should use complex characters?
        next
      else
        raise_report
      end
    end

    self.comments
  end

  private

  ## Matched `//`
  def scan_oneline_comment
    scanner = build_scanner
    line = self.current_line
    comment = scanner.scan(/^.*$/).strip
    self.add_comment(line, comment)
  end

  ## Matched `/* ... */`
  def scan_multi_comment
    scanner = build_scanner

    until scanner.eos? || scanner.scan(%r!\s*\*/!) # Removes dead-end of comment
      next if scanner.scan(StripComment::Scanner::REGEXP[:BREAK])
      line = scanner.scan(%r{(.?(?!\*/))+.})

      if %r!^(?:[ *]*)(?<comment>.*)! =~ line
        self.add_comment(self.current_line, comment)
      end
    end
  end
end

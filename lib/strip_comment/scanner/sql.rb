class StripComment::Scanner::Sql < StripComment::Scanner
  filename /\.sql$/
  filetype 'sql'

  include StripComment::Scanner::Concerns::SlashScanner
end

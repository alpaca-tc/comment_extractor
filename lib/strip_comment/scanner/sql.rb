class StripComment::Scanner::Sql < StripComment::Scanner
  disable!
  filename /\.sql$/
  filetype 'sql'
end

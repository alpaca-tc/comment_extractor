class StripComment::Scanner::Lua < StripComment::Scanner
  disable!
  filename /\.lua$/
  filetype 'lua'
end

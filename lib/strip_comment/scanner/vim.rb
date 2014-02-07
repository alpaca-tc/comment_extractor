class StripComment::Scanner::Vim < StripComment::Scanner
  disable!
  filename /\.vim$/
  filetype 'vim'
end

class StripComment::Scanner::Perl < StripComment::Scanner
  disable!
  filename /\.(pm|pl)$/
  filetype 'perl'
end

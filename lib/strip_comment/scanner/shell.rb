class StripComment::Scanner::Shell < StripComment::Scanner
  disable!
  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'
end

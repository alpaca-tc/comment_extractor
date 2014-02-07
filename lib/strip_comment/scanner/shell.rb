class StripComment::Scanner::Shell < StripComment::Scanner
  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'
end

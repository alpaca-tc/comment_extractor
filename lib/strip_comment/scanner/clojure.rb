class StripComment::Scanner::Clojure < StripComment::Scanner
  disable!
  filename /\.clj$/
  filetype 'clojure'
end

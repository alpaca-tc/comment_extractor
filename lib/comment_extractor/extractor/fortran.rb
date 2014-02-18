require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Fortran < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'

  define_default_bracket
  comment start_with: '!'
end

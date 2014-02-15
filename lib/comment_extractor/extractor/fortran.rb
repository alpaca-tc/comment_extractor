class CommentExtractor::Extractor::Fortran < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'

  define_default_bracket
  define_rule start: '!'
end

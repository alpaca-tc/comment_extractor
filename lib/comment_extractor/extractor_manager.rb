require 'comment_extractor/extractor'

module CommentExtractor
  module ExtractorManager
    @@extractors = {}

    def self.default_extractors
      %i[
        C CC CLASS CLOJURE COFFEE CPP
        CS CSS CXX D ERLANG FORTRAN GO H HAML
        HASKELL HPP HTML JAVA JAVA_SCRIPT LISP
        LUA M MARKDOWN MM PERL PHP PYTHON
        RUBY SASS SCALA SCSS SHELL SQF
        SQL SQS TEX
      ]
    end

    def self.regist_extractor(klass_or_symbol)
      extractor = klass_or_symbol.is_a?(Extractor) ? klass_or_symbol : nil
      @@extractors[:"#{klass_or_symbol}"] ||= extractor
    end
  end
end

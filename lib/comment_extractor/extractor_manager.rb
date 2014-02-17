require 'comment_extractor/extractor'
require 'comment_extractor/file'

using CommentExtractor::DetectableSchemeFile

module CommentExtractor
  module ExtractorManager
    class << self
      def default_extractors
        %i[
          C Cc Class Clojure Coffee Cpp
          Cs Css Cxx D Erlang Fortran Go H Haml
          Haskell Hpp Html Java JavaScript Lisp
          Lua M Markdown Mm Perl Php Python
          Ruby Sass Scala Scss Shell Sqf
          Sql Sqs Tex
        ]
      end

      def regist_extractor(klass_or_symbol)
        initialize_extractors! unless instance_variable_defined?(:@extractors)

        @extractor_definitions = nil
        extractor = klass_or_symbol.is_a?(Extractor) ? klass_or_symbol : nil
        extractors[:"#{klass_or_symbol}"] = extractor
      end

      def can_extract(file_path)
        return if File.binary?(file_path)

        extractor = nil
        if shebang = File.shebang(file_path)
          extractor = find_extractor_by_shebang(shebang)
        end

        unless extractor
          extractor = find_extractor_by_filename(file_path)
        end

        extractor
      end

      private

      def defined_extractor_finders
        @defined_extractor_finders ||= []
      end

      def define_extractor_finder_by(*keys)
        defined_extractor_finders.concat(keys)

        keys.each do |key|
          define_singleton_method "find_extractor_by_#{key}" do |value|
            find_extractor_by(key, value)
          end
        end
      end

      def initialize_extractors!(new_extractors = default_extractors)
        extractors # Initialize @extractors
        new_extractors.each do |extractor|
          self.regist_extractor(extractor)
        end

        self
      end

      def find_extractor_by(key, value)
        case key
        when :filename, :shebang
          # Regexp optimization which can find value O(1)
          if extractor_definitions[key][:regexp] =~ value
            index = $~[1..-1].rindex($~[0])
            extractor_definitions[key][:values][index]
          end
        when :filetype
          extractor_definitions[:filetype][value]
        end
      end

      def extractor_definitions
        @extractor_definitions ||= build_extractor_definitions
      end

      def build_extractor_definitions
        definitions = Hash.new { |h,k| h[k] = { regexp: nil, values: [] } }

        finders = defined_extractor_finders.dup
        finders.delete(:filetype)
        definitions[:filetype] = build_filetype_extractor_definitions

        finders.each do |finder|
          regexp_keys = []
          values = []

          extractors.each do |name, value|
            extractor = extractors[name] = value || Extractor.const_get(name)

            if schema = extractor.send(finder)
              # [review] - Maybe my optimization way is not better
              regexp_source = schema.is_a?(Regexp) ? schema.source : schema
              regexp_keys << "(#{regexp_source})"
              values << extractor
            end
          end

          unless values.empty?
            definitions[finder][:values] = values
            definitions[finder][:regexp] = Regexp.new(regexp_keys.join('|'))
          end
        end

        definitions
      end

      def build_filetype_extractor_definitions
        definitions = Hash.new { |h,k| h[k] = [] }

        extractors.each_with_object(definitions) do |(name, value), memo|
          extractor = extractors[name] = value || Extractor.const_get(name)
          filetypes = *extractor.filetype
          filetypes.each { |filetype| memo[filetype] = extractor }
        end
      end

      def extractors
        @extractors ||= {}
      end
    end

    # define :find_extractor_by_shebang, :find_extractor_by_filename
    define_extractor_finder_by *Extractor::SCHAME_ACCESSOR_NAMES
  end
end

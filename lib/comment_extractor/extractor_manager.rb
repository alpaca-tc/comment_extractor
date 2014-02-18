require 'comment_extractor'
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
          Sql Sqs Tex Yaml
        ]
      end

      def regist_extractor(klass_or_symbol)
        @extractor_definitions = nil
        extractor = klass_or_symbol.is_a?(Extractor) ? klass_or_symbol : nil
        extractors[:"#{klass_or_symbol}"] = extractor

        unless extractor
          filename = "#{klass_or_symbol}".gsub(/\W/, '').gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase
          file_path = "comment_extractor/extractor/#{filename}"
          Extractor.autoload klass_or_symbol, file_path
        end
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

        if ::CommentExtractor.configuration.use_default_extractor
          extractor = default_extractor unless extractor
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

            next if extractor.disabled?

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
        return @extractors if @extractors
        @extractors = {}
        initialize_extractors!

        @extractors
      end

      private

      def default_extractor
        ::CommentExtractor.configuration.default_extractor
      end
    end

    # define :find_extractor_by_shebang, :find_extractor_by_filename
    define_extractor_finder_by *Extractor::SCHAME_ACCESSOR_NAMES
  end
end

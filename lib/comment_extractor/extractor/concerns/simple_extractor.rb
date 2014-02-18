require 'comment_extractor/smart_string_scanner'

using CommentExtractor::SmartStringScanner

class CommentExtractor::Extractor
  module Concerns
    module SimpleExtractor
      include CommentExtractor::CodeObject::Comment::Type

      def self.included(k)
        k.class_eval do |klass|
          extend ClassMethods
        end
      end

      def self.attr_definition(*keys)
        keys.each do |key|
          define_method key do
            self.class.instance_variable_get("@#{key}") || []
          end
        end
      end
      attr_definition :brackets, :comment_regexp,
        :ignore_patterns, :complicate_conditions

      module ClassMethods
        include CommentExtractor::CodeObject::Comment::Type

        def included(k)
          self.instance_variables.each do |key|
            k.instance_variable_set(key, self.instance_variable_get(key))
          end
        end

        def comment(start_with: nil, end_with: nil, type: ONE_LINER_COMMENT)
          @comment_regexp ||= []
          raise ArgumentError unless [type, start_with].all?

          definition = { start_with: build_regexp(start_with), type: type, end_with: end_with }

          if type == BLOCK_COMMENT
            definition[:end_with] = build_regexp(end_with, Regexp::MULTILINE)
          end
          @comment_regexp << definition
        end

        def define_ignore_patterns(*patterns)
          @ignore_patterns ||= []
          @ignore_patterns += patterns
        end

        def define_bracket(bracket, options = 0)
          start_regexp = build_regexp(bracket)
          stop_regexp = if bracket.is_a?(Regexp)
                          join_regexp(/(?<!\\)/, bracket)
                        else
                          /(?<!\\)#{bracket}/
                        end
          stop_regexp = Regexp.new(stop_regexp.source, options)
          append_bracket(start_regexp, stop_regexp)
        end

        def define_regexp_bracket
          append_bracket(%r!/(?=[^/])!, /(?<!\\)\//)
        end

        def define_default_bracket
          define_bracket('"', Regexp::MULTILINE)
          define_bracket("'", Regexp::MULTILINE)
        end

        def append_bracket(start_with, end_with)
          @brackets ||= []
          @brackets << { start_with: start_with, end_with: end_with }
        end

        def define_complicate_condition(&proc_object)
          @complicate_conditions ||= []
          @complicate_conditions << proc_object
        end

        private

        def join_regexp(*regexp)
          # [review] - Should I ignore regexp options?
          Regexp.new(regexp.map { |v| v.source }.inject(:+))
        end

        def build_regexp(str_or_reg, type = 0)
          str_or_reg = str_or_reg.source if str_or_reg.respond_to?(:source)
          Regexp.new(str_or_reg, type)
        end
      end

      def scan
        until scanner.eos?
          case
          when scan_ignore_patterns
            next
          when scan_complicate_conditions
            next
          when scan_comment
            next
          when scan_bracket
            next
          when scanner.scan(CommentExtractor::Extractor::REGEXP[:BREAK])
            next
          when scanner.scan(/./)
            next
          else
            raise_report
          end
        end
      end

      private

      def scan_complicate_conditions
        complicate_conditions.each do |proc_object|
          return if self.instance_eval(&proc_object)
        end

        nil
      end

      def scan_bracket
        brackets.each do |definition|
          start_with = definition[:start_with]
          end_with = definition[:end_with]
          next unless scanner.scan(start_with)

          new_regexp = Regexp.new(/.*?/.source + end_with.source, end_with.options)
          return scanner.scan(new_regexp)
        end

        nil
      end

      def scan_ignore_patterns
        ignore_patterns.each do |pattern|
          return true if scanner.scan(pattern)
        end

        nil
      end

      def scan_comment
        comment_regexp.each do |definition|
          next unless scanner.scan(definition[:start_with])

          result = case definition[:type]
                   when ONE_LINER_COMMENT
                     identify_single_line_comment
                   when BLOCK_COMMENT
                     identify_multi_line_comment(definition[:end_with])
                   else
                     raise_report
                   end

          return result
        end

        nil
      end

      def identify_single_line_comment
        line_number = scanner.current_line
        comment = scanner.scan(/^.*$/)
        metadata = { type: ONE_LINER_COMMENT }
        comment_object = build_comment(line_number, comment, **metadata)

        code_objects << comment_object
      end

      def identify_multi_line_comment(regexp)
        line_no = scanner.current_line
        stop_regexp = Regexp.new(/.*?/.source + regexp.source, regexp.options)
        comment_block = scanner.scan(stop_regexp)

        remove_tail_regexp = Regexp.new(regexp.source + /$/.source)
        comments = comment_block.sub(remove_tail_regexp, '').split("\n")
        comments.each_with_index do |comment, index|
          metadata = { type: BLOCK_COMMENT }
          code_objects << build_comment(line_no + index, comment, metadata)
        end
      end
    end
  end
end

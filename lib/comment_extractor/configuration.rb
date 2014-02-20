require 'comment_extractor/extractors'
require 'comment_extractor/extractor/text'

module CommentExtractor
  class Configuration
    def initialize(attributes = {})
      required_attributes = self.class.required_attributes.dup

      attributes.each do |key, value|
        required_attributes.delete(key)
        send("#{key}=", value)
      end

      unless required_attributes.empty?
        keys = required_attributes.keys.map { |v| ":#{v}" }.join(', ')
        raise ArgumentError, "Unable to initialize #{keys} without attribute"
      end

      @extractors = Extractors.default_extractors
      @default_extractor = Extractor::Text
      @use_default_extractor = true
    end

    class << self
      def add_setting(name, opts={})
        attr_accessor name

        define_predicating_for(name) if opts.delete(:predicate)
        define_required_attribute(name) if opts.delete(:required)
      end

      def required_attributes
        @required_attributes ||= {}
      end

      private

      def define_required_attribute(*names)
        names.each do |name|
          required_attributes[name] = nil
        end
      end

      def define_predicating_for(*names)
        names.each do |name|
          define_method "#{name}?" do
            !!send(name)
          end
        end
      end
    end

    add_setting :extractors
    add_setting :default_extractor
    add_setting :use_default_extractor
  end
end

module CommentExtractor
  # [review] - unfortunately, Configuration did not used
  class Configuration
    @@default_values = {}
    @@required_attributes = {}

    def initialize(attributes = {})
      @@default_values.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      attributes.each do |key, value|
        method_name = "#{key}="
        send(method_name, value) if respond_to?(method_name)
      end

      @@required_attributes.each_key do |key|
        raise "Unable to initialize #{key} without attribute" unless self.send(key)
      end
    end

    def self.add_setting(name, opts={})
      attr_accessor name

      if value = opts.delete(:default)
        @@default_values[name] = value
      end

      define_predicate_for(name) if opts.delete(:predicate)
      define_required_attribute(name) if opts.delete(:required)
    end

    private

    def self.define_required_attribute(*names)
      names.each do |name|
        @@required_attributes[name] = nil
      end
    end

    def self.define_predicate_for(*names)
      names.each do |name|
        define_method "#{name}?" do
          !!send(name)
        end
      end
    end

    add_setting :root_path, required: true
    add_setting :dry_run, default: false
    add_setting :files, default: []
    add_setting :directories, default: []
    add_setting :ignore_list, default: []
  end
end

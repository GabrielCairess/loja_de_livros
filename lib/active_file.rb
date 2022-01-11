#encoding: utf-8

module ActiveFile
  def included(base)
    base.extend ClassMethods
    base.class_eval do
      attr_reader :id, :destroyed, :new_record

      def initialize(params = {})
        @id = self.class.next_id
        @destroyed = false
        @new_record = true

        params.each do |key, value|
          instance_variable_set "@#{key}", value
        end
      end
    end
  end

  def save
    @new_record = false

    File.open("db/revistas/#{@id}.yml", "w") do |file|
      file.puts serialize
    end
  end

  def destroy
    unless @destroyed or @new_record
      @destroyed = true
      FileUtils.rm "db/revistas/#{id}.yml"
    end
  end

  module ClassMethods
    def field(name)
      @fields ||= []
      @fields << name

      get = %Q{
        def #{name}
          @#{name}
        end
      }

      set = %Q{
        def #{name}=(valor)
          @#{name}=valor
        end
              
      }
      
      self.class_eval get
      self.class_eval set
    end

    def method_missing(name, *args, &block)
      super unless name.to_s =~ /^find_by_(.*)/

      argument = args.first
      field = name.to_s.split("_").last
      super if @fields.include? field

      load_all.select do |object|
        should_select? object, field, argument
      end
    end

    private 

    def should_select?
      if argument.kind_of? Regexp
        object.send(field) =~ argument
      else
        object.send(field) == argument
      end
    end

    def load_all
      Dir.glob('db/revistas/*.yml').map do |file|
        deserialize file
      end
    end

    def deserialize(file)
      YAML.load File.open(file, "r")
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def find(id)
    raise DocumentNotFound, "Arquivo db/revistas/#{id}.yml.", caller unless File.exists?("db/revistas/#{id}.yml")
  
    YAML.load File.open("db/revistas/#{id}.yml", "r")
  end

  def next_id
    Dir.glob("db/revistas/*.yml").size + 1
  end
  
  private
  
  def serialize
    YAML.dump self
  end
end
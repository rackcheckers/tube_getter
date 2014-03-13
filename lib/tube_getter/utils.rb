class Hash
  # By default, only instances of Hash itself are extractable.
  # Subclasses of Hash may implement this method and return
  # true to declare themselves as extractable. If a Hash
  # is extractable, Array#extract_options! pops it from
  # the Array when it is the last element of the Array.
  def extractable_options?
    instance_of?(Hash)
  end
end

class Array
  # Extracts options from a set of arguments. Removes and returns the last
  # element in the array if it's a hash, otherwise returns a blank hash.
  #
  #   def options(*args)
  #     args.extract_options!
  #   end
  #
  #   options(1, 2)        # => {}
  #   options(1, 2, a: :b) # => {:a=>:b}
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end
end

module TubeGetter
  module Utils
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      # bluntly stolen from Ruby on Rails
      # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/module/attribute_accessors.rb
      
      def mattr_reader(*syms)
        options = syms.extract_options!
        syms.each do |sym|
          raise NameError.new("invalid attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
          class_eval(<<-EOS, __FILE__, __LINE__ + 1)
            @@#{sym} = nil unless defined? @@#{sym}
      
            def self.#{sym}
              @@#{sym}
            end
          EOS
      
          unless options[:instance_reader] == false || options[:instance_accessor] == false
            class_eval(<<-EOS, __FILE__, __LINE__ + 1)
              def #{sym}
                @@#{sym}
              end
            EOS
          end
          class_variable_set("@@#{sym}", yield) if block_given?
        end
      end
      alias :cattr_reader :mattr_reader
      
      def mattr_writer(*syms)
        options = syms.extract_options!
        syms.each do |sym|
          raise NameError.new("invalid attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
          class_eval(<<-EOS, __FILE__, __LINE__ + 1)
            @@#{sym} = nil unless defined? @@#{sym}
      
            def self.#{sym}=(obj)
              @@#{sym} = obj
            end
          EOS
      
          unless options[:instance_writer] == false || options[:instance_accessor] == false
            class_eval(<<-EOS, __FILE__, __LINE__ + 1)
              def #{sym}=(obj)
                @@#{sym} = obj
              end
            EOS
          end
          send("#{sym}=", yield) if block_given?
        end
      end
      alias :cattr_writer :mattr_writer
      
      def mattr_accessor(*syms, &blk)
        mattr_reader(*syms, &blk)
        mattr_writer(*syms, &blk)
      end
      alias :cattr_accessor :mattr_accessor
      
      # def cattr_accessor(attribute_name, default_value=nil)
      #   class_eval(<<-EOS, __FILE__, __LINE__)
      #     def self.#{attribute_name}
      #       @@#{attribute_name}
      #     end
      # 
      #     def self.#{attribute_name}=(value)
      #       @@#{attribute_name}=value
      #     end
      #   EOS
      #   
      #   if default_value
      #     class_eval("@@#{attribute_name} = #{default_value}", __FILE__, __LINE__)
      #   else
      #     class_eval("@@#{attribute_name} = nil", __FILE__, __LINE__)
      #   end
      # end
    end
  end
end
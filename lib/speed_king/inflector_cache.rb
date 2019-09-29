# frozen_string_literal: true

module InflectorCache
  @camelize_cache = {}
  @underscore_cache = {}
  class << self
    attr_reader :camelize_cache, :underscore_cache
  end

  def camelize(term, uppercase_first_letter = true)
    return super unless uppercase_first_letter

    if (cached = InflectorCache.camelize_cache[term])
      cached.dup
    else
      super
    end
  end

  def underscore(camel_cased_word)
    if (cached = InflectorCache.underscore_cache[camel_cased_word])
      cached.dup
    else
      super
    end
  end
end

ActiveSupport.on_load :active_record do
  ActiveSupport::Inflector.extend InflectorCache
end

module SchemaStatementsExtension
  def columns(table_name)
    result = super

    unless InflectorCache.camelize_cache[table_name]
      InflectorCache.camelize_cache[table_name] = table_name.camelize
    end
    unless InflectorCache.underscore_cache[table_name]
      InflectorCache.underscore_cache[table_name] = table_name.underscore
    end

    result
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend SchemaStatementsExtension

# frozen_string_literal: true

module I18nCache
  def self.extended(obj)
    obj.instance_variable_set :@i18n_cache, {}
  end

  def translate(*args, **options)
    cache = @i18n_cache[I18n.locale] ||= {}
    cache_key = args << options

    cache[cache_key] || begin
      result = super
      cache[cache_key] = result
      result
    end
  end
  alias t translate
end

I18n.extend I18nCache

# frozen_string_literal: true

module SpeedKing
  module LayoutCache
    module CachedLayout
      private def _layout(lookup_context, formats)
        cache = self.class.instance_variable_get :@_layout_cache
        implied_layout_name = self.class.send(:_implied_layout_name)
        prefixes = /\blayouts/.match?(implied_layout_name) ? [] : ["layouts"]

        cache[[implied_layout_name, prefixes, formats]] ||= super
      end
    end

    def _write_layout_method # :nodoc:
      super

      if _layout.nil? || (String === _layout)
        @_layout_cache = {}
        prepend CachedLayout
      end
    end
  end
end

ActionView::Layouts::ClassMethods.prepend SpeedKing::LayoutCache

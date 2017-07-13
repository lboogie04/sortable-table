module SortableTable
  module ActionViewExtension
    def sort_by(column, options = {})
      current_column = options.delete(:current_column) || SortableTable::SortColumn.new(nil, nil)
      title = options.delete(:title) || column.titleize
      prefix = options.delete(:prefix)
      is_current_column = column == current_column.column
      options_class = options.delete(:class)
      css_class = is_current_column ? "current #{current_column.direction} #{options_class}" : options_class
      direction = is_current_column && current_column.direction == 'asc' ? 'desc' : 'asc'
      icon = current_column.direction == 'asc' ? 'fa-caret-up fa' : 'fa-caret-down fa'
      icon = is_current_column ? icon : ''
      sort_params = { "#{prefix}sort" => column,
                                  "#{prefix}direction" => direction,
                                  "#{prefix}page" => nil }
      if options.has_key?(:route_method)
        goto = options.delete(:route_method).call sort_params
      else
        goto = params.merge( sort_params )
      end
      link_to "#{title} <span class='#{icon}'></span>".html_safe, goto, options.merge( {class: css_class } )
    end
  end
end

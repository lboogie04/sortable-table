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
      link_to title, params.merge("#{prefix}sort" => column,
                                  "#{prefix}direction" => direction,
                                  "#{prefix}page" => nil),
              options.merge( {class: css_class } )
    end
  end
end

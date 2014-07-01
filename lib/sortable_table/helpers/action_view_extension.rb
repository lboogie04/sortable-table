module SortableTable
  module ActionViewExtension
    def sort_by(column, options = {})
      current_column = options[:current_column] || SortableTable::SortColumn.new(nil, nil)
      title = options[:title] || column.titleize
      prefix = options[:prefix]
      is_current_column = column == current_column.column
      css_class = is_current_column ? "current #{current_column.direction}" : nil
      direction = is_current_column && current_column.direction == 'asc' ? 'desc' : 'asc'
      link_to title, params.merge("#{prefix}sort" => column,
                                  "#{prefix}direction" => direction,
                                  "#{prefix}page" => nil),
              class: css_class
    end
  end
end
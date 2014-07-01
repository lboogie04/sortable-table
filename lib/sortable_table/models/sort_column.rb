module SortableTable
  class SortColumn
    SORT_DIRECTIONS = %w(asc desc)
    attr_reader :column, :direction, :order

    def initialize(sort_column, sort_direction, options = {})
      @column = sort_column
      @direction = SORT_DIRECTIONS.include?(sort_direction) ? sort_direction : 'asc'
      @order = options[:order] || "#{column} #{direction}"
    end
  end
end

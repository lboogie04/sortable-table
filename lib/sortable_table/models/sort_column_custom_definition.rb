module SortableTable
  class SortColumnCustomDefinition
    attr_reader :column, :ordering

    def initialize(column, options = {})
      @column = column
      @ordering = { 'asc' => options[:asc], 'desc' => options[:desc] }
    end

    def create_sort_column(direction)
      SortColumn.new(column, direction, order: ordering[direction] || ordering['asc'])
    end
  end
end

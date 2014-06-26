module SortableTable
  class SortColumnDefinition
    attr_reader :column

    def initialize(column)
      @column = column
    end

    def create_sort_column(direction)
      SortColumn.new(column, direction)
    end
  end
end

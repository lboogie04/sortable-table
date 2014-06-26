module SortableTable
  class SortTable
    attr_reader :column_definitions, :default_column, :default_direction

    def initialize(column_definitions, options = {})
      @default_column = options[:default_column] || column_definitions.first.column
      @default_direction = options[:default_direction] || :asc
      @column_definitions = column_definitions.each_with_object({}) do |column_definition, acc|
        acc[column_definition.column] = column_definition
        acc
      end
    end

    def sort_column(column, direction)
      column_definition = column_definitions[column] || column_definitions[default_column]
      column_definition.create_sort_column(direction || default_direction.to_s)
    end
  end
end

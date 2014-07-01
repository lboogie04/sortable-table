module SortableTable
  describe SortColumnDefinition do
    it 'has column' do
      definition = SortColumnDefinition.new('InvoiceNumber')
      expect(definition.column).to eq('InvoiceNumber')
    end

    it 'can create an ascending sort column' do
      definition = SortColumnDefinition.new('Timmy')

      sort_column = definition.create_sort_column('asc')

      expect(sort_column.column).to eq('Timmy')
      expect(sort_column.direction).to eq('asc')
      expect(sort_column.order).to eq('Timmy asc')
    end

    it 'can create a descending sort column' do
      definition = SortColumnDefinition.new('Jimmy')

      sort_column = definition.create_sort_column('desc')

      expect(sort_column.column).to eq('Jimmy')
      expect(sort_column.direction).to eq('desc')
      expect(sort_column.order).to eq('Jimmy desc')
    end
  end
end
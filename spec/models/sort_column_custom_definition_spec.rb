module SortableTable
  describe SortColumnCustomDefinition do
    it 'has a column' do
      definition = SortColumnCustomDefinition.new('Name')
      expect(definition.column).to eq('Name')
    end

    it 'can create an ascending sort column' do
      definition = SortColumnCustomDefinition.new('Jimmy',
                                                  asc: 'Jimmy asc, Timmy desc',
                                                  desc: 'Jimmy desc, Timmy asc')

      sort_column = definition.create_sort_column('asc')

      expect(sort_column.column).to eq('Jimmy')
      expect(sort_column.direction).to eq('asc')
      expect(sort_column.order).to eq('Jimmy asc, Timmy desc')
    end

    it 'creates an ascending sort column when no sort direction is passed' do
      definition = SortColumnCustomDefinition.new('Jimmy',
                                                  asc: 'Jimmy asc, Timmy desc',
                                                  desc: 'Jimmy desc, Timmy asc')

      sort_column = definition.create_sort_column(nil)

      expect(sort_column.column).to eq('Jimmy')
      expect(sort_column.direction).to eq('asc')
      expect(sort_column.order).to eq('Jimmy asc, Timmy desc')
    end

    it 'can create a descending sort column' do
      definition = SortColumnCustomDefinition.new('Jimmy',
                                                  asc: 'Jimmy asc, Timmy desc',
                                                  desc: 'Jimmy desc, Timmy asc')

      sort_column = definition.create_sort_column('desc')

      expect(sort_column.column).to eq('Jimmy')
      expect(sort_column.direction).to eq('desc')
      expect(sort_column.order).to eq('Jimmy desc, Timmy asc')
    end
  end
end
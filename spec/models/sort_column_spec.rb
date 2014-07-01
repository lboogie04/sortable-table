module SortableTable
  describe SortColumn do
    it 'direction only allows asc and desc' do
      expect(SortColumn.new('Timmy', 'asc').direction).to eq('asc')
      expect(SortColumn.new('Timmy', 'desc').direction).to eq('desc')
      expect(SortColumn.new('Timmy', 'Jimmy').direction).to eq('asc')
    end

    it 'create order based on column and direction' do
      expect(SortColumn.new('Timmy', 'asc').order).to eq('Timmy asc')
      expect(SortColumn.new('Timmy', 'desc').order).to eq('Timmy desc')
    end

    it 'allows a custom order' do
      column = SortColumn.new('Name', 'asc', order: 'Name asc, Number desc')
      expect(column.order).to eq('Name asc, Number desc')
    end
  end
end
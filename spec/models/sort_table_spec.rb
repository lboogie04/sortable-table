module SortableTable
  describe SortTable do
    describe "sort_column" do
      it 'use the first column ascending as the default sort when not specified' do
        number_sort_definition = SortColumnDefinition.new('Number')
        name_sort_definition = SortColumnDefinition.new('Name')
        sort_table = SortTable.new([number_sort_definition, name_sort_definition])

        sort_column = sort_table.sort_column(nil, nil)

        expect(sort_column.order).to eq('Number asc')
      end

      it 'return default ordering information if sort column is not passed' do
        number_sort_definition = SortColumnDefinition.new('Number')
        name_sort_definition = SortColumnDefinition.new('Name')
        sort_table = SortTable.new([number_sort_definition, name_sort_definition],
          default_column: 'Name', default_direction: :desc)

        sort_column = sort_table.sort_column(nil, nil)

        expect(sort_column.order).to eq('Name desc')
      end

      it 'return default ordering information for a nil column, passed sort direction' do
        number_definition = SortColumnDefinition.new('InvoiceNumber')
        date_definition = SortColumnDefinition.new('InvoiceDate')
        sort_table = SortTable.new([number_definition, date_definition], default_column: 'InvoiceNumber')

        sort_column = sort_table.sort_column(nil, 'asc')

        expect(sort_column.column).to eq('InvoiceNumber')
      end

      it 'return default ordering information for a column that is not sortable' do
        number_definition = SortColumnDefinition.new('InvoiceNumber')
        date_definition = SortColumnDefinition.new('InvoiceDate')
        sort_table = SortTable.new([number_definition, date_definition], default_column: 'InvoiceNumber')

        sort_column = sort_table.sort_column('Invoice', 'asc')

        expect(sort_column.column).to eq('InvoiceNumber')
      end

      it 'return asc ordering information for a column that is sortable' do
        number_definition = SortColumnDefinition.new('InvoiceNumber')
        date_definition = SortColumnDefinition.new('InvoiceDate')
        sort_table = SortTable.new([number_definition, date_definition], default_column: 'InvoiceNumber')

        sort_column = sort_table.sort_column('InvoiceDate', 'asc')

        expect(sort_column.order).to eq('InvoiceDate asc')
      end

      it 'return desc ordering information for a column that is sortable' do
        number_definition = SortColumnDefinition.new('InvoiceNumber')
        date_definition = SortColumnDefinition.new('InvoiceDate')
        sort_table = SortTable.new([number_definition, date_definition], default_column: 'InvoiceNumber')

        sort_column = sort_table.sort_column('InvoiceDate', 'desc')

        expect(sort_column.order).to eq('InvoiceDate desc')
      end
    end
  end
end
module SortableTable
  class Railtie < Rails::Railtie
    initializer 'sortable-table' do |app|
      require 'sortable-table/models/sort_column'
      require 'sortable-table/models/sort_column_custom_definition'
      require 'sortable-table/models/sort_column_definition'
      require 'sortable-table/models/sort_table'
      
      ActiveSupport::on_load(:action_view) do
        ActionView::Base.send :include, SortableTable::ActionViewExtension
      end
    end
  end
end
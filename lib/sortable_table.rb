begin
  require 'rails'
rescue LoadError
  # do nothing
end

require 'sortable-table/helpers/action_view_extension'
require 'sortable-table/models/sort_column'
require 'sortable-table/models/sort_column_custom_definition'
require 'sortable-table/models/sort_column_definition'
require 'sortable-table/models/sort_table'

require 'sortable-table/railtie' if defined?(Rails)

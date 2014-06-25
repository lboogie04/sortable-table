# Sortable Column by [Caselle](http://www.caselle.com/)

The sortable-column gem allows you to sort table columns similar to [RailsCasts #228 Sortable Table Columns](http://railscasts.com/episodes/228-sortable-table-columns).

Rather than adding helper methods to a controller, sortable-column creates a sort column object. This approach provides the following benefits:

1. More complex sort criteria can be defined for a column. The RailsCasts approach only allows a single column to be sorted. This approach allows additional columns to be involved in the column sort.
2. The sorting logic is not duplicated across controllers, and controllers don't have to define helper methods.
3. It makes it easier for multiple tables on a page to have sortable columns.

## Installing

```ruby
gem 'sortable-column', github: 'caselle/sortable-column'
```

## Configuration

Using sort column involves the following steps:

1. Define which columns in your table can be sorted, and how they are sorted.
2. Using the parameters passed into your controller action, get the current sort column.
3. Use the current sort column to order your data.
4. Include the Sortable module in a helper, which adds the ```sort_by``` helper method to your views.
5. Use the ```sort_by``` helper, to add links to the table header row which allow the table to be re-sorted by those columns.
6. Use the ```hidden_sort_tags``` helper, to keep track of the current sort column and direction.

### Controller

Create sort column definitions which define how each column can be sorted. Create a sort table that holds those sort column definitions as well as optional default sort column information. Then use the sort table to get the current sort column.

```ruby
def sort_column
  date_sort = SortableColumn::SortColumnCustomDefinition.new(
    'date',
    asc: 'date asc, number asc',
    desc: 'date desc, number desc')
  number_sort = SortableColumn::SortColumnDefinition.new('number')
  sort_table = SortableColumn::SortTable.new([date_sort, number_sort])
  sort_table.sort_column(params[:sort], params[:direction])
end
```
Use the current sort column to order the records you pass to the view.

```ruby
def index
  @sort_column = sort_column
  @items = Model.order(@sort_column.order)
end
```

Make the sort column available to the view, it will be used by the ```sort_by``` helper.

### Helper

Include the ```SortableColumn::Sortable``` module which will make the sort_by helper available to your view. You can include it on the application helper or the helper for your controller.

```ruby
module ApplicationHelper
  include SortableColumn::Sortable
```

### View

Use the ```hidden_sort_tags``` helper to add some hidden field tags to your view to store the current sort column and direction.

```haml
= hidden_sort_tags @sort_column
```

Use the ```sort_by``` helper to add links to columns which you want to sort.

```haml
%table
  %tbody
    %tr
      %th= sort_by 'number', title: 'Number', current_column: @sort_column
      %th= sort_by 'date', title: 'Date', current_column: @sort_column
      %th Description
  %tbody
    = render @items
```

If the column passed to the ```sort_by``` is the current sort column, the sort link it creates will switch the direction that the column is sorted by.

## Sorting Multiple Tables

If you have multipe tables to sort on a view, then you'll need to add a prefix to the sorting params for each table. E.g., if you have a foo table and a bar table, instead of just having :sort and :direction params, you would want ```:foo_sort```, ```:foo_direction```, ```:bar_sort```, and ```:bar_direction``` params. In other words, you'll want a table-specific prefix for each param.

To add a table-specific prefix, do the following:

Assign a sort column for each table. Use the param prefix when generating the sort column.

```ruby
sort_table.sort_column(params[:foo_sort], params[:foo_direction])
```

Pass ```:prefix``` to the ```hidden_sort_tags``` helper.

```haml
= hidden_sort_tags @foo_sort_column, prefix: 'foo_'
```

Pass ```:prefix``` to the ```sort_by helper```.

```haml
%th= sort_by 'name', title: 'Name', prefix: 'foo_', current_column: @foo_sort_column
```

## <a name="sort_column_definitions"></a>Sort Column Definitions

There are two types of sort column definitions: ```SortColumnDefinition``` and ```SortColumnCustomDefinition```.

### Sort Column Definition

```SortColumnDefinition``` simply allows you to pass the column used to sort. Depending on the sort direction the order will simply be "&lt;column> asc" or "&lt;column> desc".

The column should be have the same casing as the database. E.g., if the column is "Timmy", create ```SortableColumn::SortColumnDefinition.new('Timmy')``` not ```SortableColumn::SortColumnDefinition.new('timmy')```.

The column name is the key used by the [SortTable](#sort_table).

### Sort Column Custom Definition

```SortColumnCustomDefinition``` allows you to specify any custom order for ascending and descending directions. The first parameter passed when creating a ```SortColumnCustomDefinition``` is the "key" used by the [SortTable](#sort_table).

```ruby
date_sort = SortableColumn::SortColumnCustomDefinition.new('date',
  asc: 'date asc, number asc',
  desc: 'date desc, number desc')
```

## <a name="sort_table"></a>Sort Table

A ```SortTable``` is used to create the current sort column based on the params passed to the controller action.

### Creation

To create a ```SortTable```, pass in the [sort column definitions](#sort_column_definitions) for the table.

Additional options that can be passed as well are:

- ```default_column```: The column to use for sorting if no sort column param is passed to the controller action. If this option is not passed, the first sort column definition is used. The value for this is the "key" of a [sort column definition](#sort_column_definitions).
- ```default_direction```: The direction to use for sorting the default column if no sort direction param is passed to the controller action. If this option is not passed, :asc is used. :asc or :desc

In the following example, date and number sort column definitions are created. If no sort params are passed to the controller action, the current sort column will be ordered by date ascending.

```ruby
date_sort = SortableColumn::SortColumnDefinition.new('date')
number_sort = SortableColumn::SortColumnDefinition.new('number')
sort_table = SortableColumn::SortTable.new([date_sort, number_sort])
```

In this example, date and number sort column definitions are created, and the default order will be number descending.

```ruby
date_sort = SortableColumn::SortColumnDefinition.new('date')
number_sort = SortableColumn::SortColumnDefinition.new('number')
sort_table = SortableColumn::SortTable.new([date_sort, number_sort],
  default_column: 'number', default_direction: :desc)
```

### Current Sort Column

Call the ```sort_column``` SortTable method to get the current sort column.

```ruby
sort_table.sort_column(params[:sort], params[:direction])
```

If ```params[:sort]``` is missing, the sort table default column will be used. If ```params[:sort]``` is not a recognized sort column definition key, the sort table default column will be used.

If ```params[:direction]``` is missing, the sort table default direction will be used.

## Sort Column

A ```SortColumn``` represents the current sort column. It has the following attributes:

- ```order```: The order that can be passed to an ActiveRecord order method. ```YourModel.order(sort_column.order)```
- ```column```: The sort column. Corresponds to a [sort column definition](#sort_column_definitions) key.
- ```direction```: The sort direction, 'asc' or 'desc'.

Generally, a user of ```SortColumn``` will only use the ```order``` attribute. The other attributes are used by helper methods.

## License

sortable-column is available under the MIT license. See the LICENSE file for more info.

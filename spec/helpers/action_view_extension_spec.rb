require 'fake_app/rails_app'
require 'rspec/rails'
require 'spec_helper'

describe 'SortableTable::ActionViewExtension', type: :helper do
  describe '#sort_by' do
    it 'add the column as the sort column and the title as the link text' do
      allow(helper).to receive(:params).and_return(controller: :items, action: :index)

      link = helper.sort_by('date', title: 'Title')

      expect(link).to eq('<a href="/items?direction=asc&amp;sort=date">Title</a>')
    end

    it 'titleize the column and use it as the link text if title is missing' do
      allow(helper).to receive(:params).and_return(controller: :items, action: :index)

      link = helper.sort_by('description')

      expect(link).to eq('<a href="/items?direction=asc&amp;sort=description">Description</a>')
    end

    it 'sorting the same column should turn asc to desc order and remove page parameter' do
      current_column = SortableTable::SortColumn.new('number', 'asc')
      allow(helper).to receive(:params).and_return(controller: :items, action: :index, page: 1)

      link = helper.sort_by('number', title: 'Title', current_column: current_column)

      expect(link).to eq('<a class="current asc" href="/items?direction=desc&amp;sort=number">Title</a>')
    end

    it "clicking the same column should turn desc to asc order and remove page parameter" do
      current_column = SortableTable::SortColumn.new('number', 'desc')
      allow(helper).to receive(:params).and_return(controller: :items, action: :index, page: 1)

      link = helper.sort_by('number', title: 'Title', current_column: current_column)

      expect(link).to eq('<a class="current desc" href="/items?direction=asc&amp;sort=number">Title</a>')
    end

    it "Adding prefix to parameters" do
      current_column = SortableTable::SortColumn.new('number', 'desc')
      allow(helper).to receive(:params).and_return(controller: :items, action: :index, invoice_page: 1)

      link = helper.sort_by('number', title: 'Title', current_column: current_column, prefix: 'invoice_')

      expect(link).to eq('<a class="current desc" href="/items?invoice_direction=asc&amp;invoice_sort=number">Title</a>')
    end
  end
end
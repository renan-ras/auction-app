module ItemsHelper
  def options_for_items_select(items)
    options_from_collection_for_select(items, 'id', ->(item) { "#{item.code} - #{item.name}" })
  end
end

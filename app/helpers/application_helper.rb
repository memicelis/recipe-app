module ApplicationHelper
  def link_class(link_name)
    active_classes = 'text-white bg-blue-700 text-white rounded-md px-3 py-2 text-sm font-medium'
    default_classes = 'text-blue-900 hover:bg-gray-200 hover:text-blue-900 rounded-md px-3 py-2 text-sm font-medium'

    active_classes_if_active = lambda do |path|
      current_page?(path) ? active_classes : default_classes
    end

    case link_name
    when 'Home' then active_classes_if_active.call(root_path)
    when 'Food List' then active_classes_if_active.call(foods_path)
    when 'My Recipes' then active_classes_if_active.call(recipes_path)
    when 'Shopping List' then active_classes_if_active.call(shopping_lists_path)
    else default_classes
    end
  end
end

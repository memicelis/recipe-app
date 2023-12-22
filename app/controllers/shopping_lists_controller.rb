class ShoppingListsController < ApplicationController
  def index
    puts "Parameters: #{params.inspect}"
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods
    @all_food = Food.all
    @missing_food = find_missing_food_items(@recipe_foods, @all_food)
    @total_food_items = @missing_food.count
    @total_price = @missing_food.sum { |item| item[:missing_price] }
  end

  private

  def find_missing_food_items(recipe_foods, all_food)
    recipe_foods.each_with_object([]) do |ingredient, missing_food|
      food = find_food_by_id(all_food, ingredient.food_id)
      add_missing_food_item(missing_food, food, ingredient) if food.present?
    end
  end

  def find_food_by_id(all_food, food_id)
    all_food.find_by(id: food_id)
  end

  def add_missing_food_item(missing_food, food, ingredient)
    return unless ingredient.quantity > food.quantity

    missing_quantity = ingredient.quantity - food.quantity
    missing_price = missing_quantity * food.price
    missing_food << { name: food.name, missing_quantity:, missing_price: }
  end
end
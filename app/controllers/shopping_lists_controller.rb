class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = Recipe.all
    @recipe_foods = RecipeFood.includes(:food).where(recipe: @recipes)
    @all_food = Food.all
    @shopping_food = find_shopping_food_items(@recipe_foods, @all_food)
    @total_food_items = @shopping_food.sum { |item| item[:shopping_quantity] }
    @total_price = @shopping_food.sum { |item| item[:shopping_price] }

    # Use an instance variable instead of a class variable
    @remaining_quantity = calculate_remaining_quantity(@all_food, @shopping_food)
  end

  private

  def find_shopping_food_items(recipe_foods, all_food)
    recipe_foods.each_with_object([]) do |ingredient, shopping_food|
      food = find_food_by_id(all_food, ingredient.food_id)
      add_shopping_food_item(shopping_food, food, ingredient) if food.present?
    end
  end

  def find_food_by_id(all_food, food_id)
    all_food.find_by(id: food_id)
  end

  def add_shopping_food_item(shopping_food, food, ingredient)
    existing_item = shopping_food.find { |item| item[:name] == food.name }

    if existing_item
      existing_item[:shopping_quantity] += ingredient.quantity
      existing_item[:shopping_price] += ingredient.quantity * food.price
    else
      shopping_quantity = ingredient.quantity
      shopping_price = shopping_quantity * food.price
      shopping_food << { name: food.name, shopping_quantity: shopping_quantity, shopping_price: shopping_price, measurement_unit: food.measurement_unit }
    end
  end

  def calculate_remaining_quantity(all_food, shopping_food)
  remaining_quantity = {}

  all_food.each do |food|
    shopping_item = shopping_food.find { |item| item[:name] == food.name }

    remaining_quantity[food.name] = {
      remaining_quantity: shopping_item[:shopping_quantity] - food.quantity,
      price: food.price,
      measurement_unit: food.measurement_unit,
      remaining_price: shopping_item[:shopping_quantity] - food.quantity * food.price
    }
  end

  remaining_quantity.select { |_, data| data[:remaining_quantity] > 0 }
end

  
  
  
end





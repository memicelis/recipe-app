class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      flash[:success] = 'Recipe Food succesfully added'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash[:error] = 'Error'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food
      @recipe_food.destroy
      flash[:notice] = 'Ingredient deleted successfully.'
    else
      flash[:alert] = 'Ingredient not found.'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end

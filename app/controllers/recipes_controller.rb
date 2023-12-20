class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = current_user.recipes.build
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_food = @recipe.recipe_foods
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    puts "Received parameters: #{params.inspect}"
    if @recipe.save
      redirect_to recipes_path(@recipe), notice: 'Recipe was succesfully added'
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public)
  end
end

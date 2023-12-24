require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let(:user) { User.new(name: 'Elis', email: 'elis@elis.com', password: 'password') }

  before do
    user.save
    sign_in user
  end

  describe 'routes' do
    it 'GET foods#index' do
      get foods_path
      expect(response).to be_successful
    end
    it 'GET foods#new' do
      get new_food_path
      expect(response).to be_successful
    end
    it 'POST foods#create with valid parameters' do
      food_params = { food: { name: 'New Food', measurement_unit: 'grams', price: 15, quantity: 3 } }
      expect { post foods_path, params: food_params }.to change { Food.count }.by(1)
      expect(response).to redirect_to(foods_path)
    end

    it 'POST foods#create with invalid parameters' do
      food_params = { food: { name: '', measurement_unit: 'grams', price: 15, quantity: 3 } }
      expect { post foods_path, params: food_params }.not_to(change { Food.count })
      expect(response).to render_template(:new)
    end

    it 'DELETE foods#destroy' do
      delete food_path(food)
      expect(response).to redirect_to(foods_path)
    end
  end
end

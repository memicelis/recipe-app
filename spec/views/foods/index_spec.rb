require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  let(:user) { User.new(name: 'Elis', email: 'elis@elis.com', password: 'password') }
  let(:food) do
    user.foods.create(name: 'Test Food', measurement_unit: 'kg', price: 10, quantity: 2, user_id: user.id)
  end

  before do
    user.save
    food.save
    sign_in user
    visit foods_path
  end

  describe 'index' do
    it 'renders a page' do
      expect(page).to have_content('Food List')
      expect(page).to have_link('Add New Food')
      within 'table' do
        expect(page).to have_content('Food')
        expect(page).to have_content('Measurement Unit')
        expect(page).to have_content('Unit Price')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Actions')

        expect(page).to have_content(food.name)
        expect(page).to have_content(food.measurement_unit)
        expect(page).to have_content(food.price)
        expect(page).to have_content(food.quantity)

        expect(page).to have_button('Delete')
      end
    end
  end
end

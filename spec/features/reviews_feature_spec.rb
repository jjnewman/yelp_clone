require 'rails_helper'

def user_signup
   visit '/users/sign_up'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    find('input[type="submit"]').click
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

feature 'reviewing' do
   before {Restaurant.create name: 'KFC'}

   scenario 'allows users to leave a review using a form' do
    user_signup
    leave_review('So so', '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('So so')
   end

   scenario 'displays an average rating for all reviews' do
    user_signup
    leave_review('So so', '3')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
   end
end

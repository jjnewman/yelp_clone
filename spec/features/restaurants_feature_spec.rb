require 'rails_helper'

def user_signup
   visit '/users/sign_up'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    find('input[type="submit"]').click
end

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content('No restaurants yet')
    end
  end

context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    user_signup
    click_link 'Add a restaurant'
    visit '/restaurants/new'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end

context 'not signed in' do
  it 'does not let a user create a restaurant if they are not signed in' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

context 'an invalid restaurant' do
  it 'does not let a user submit a name that is too short' do
    user_signup
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'kf'
    click_button 'Create Restaurant'
    expect(page).not_to have_css 'h2', text: 'kf'
    expect(page).to have_content 'error'
    end
  end
end

context 'viewing restaurants' do

  let!(:kfc){Restaurant.create(name:'KFC')}

  scenario 'let a user view a restaurant' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq "/restaurants/#{kfc.id}"
  end
end

context 'editing restaurants' do

  before {Restaurant.create name: 'KFC'}

  scenario 'let a user edit a restaurant' do
    user_signup
    click_link 'Edit KFC'
    fill_in 'Name', with: 'Kentucky Fried Chicken'
    click_button 'Update Restaurant'
    expect(page).to have_content 'Kentucky Fried Chicken'
    expect(current_path).to eq '/restaurants'
  end

  context 'not signed in' do
  it 'does not let a user edit a restaurant if they are not signed in' do
    visit '/restaurants'
    click_link 'Edit KFC'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  # context 'not created by user' do
  # it 'does not let a user edit a restaurant which they have not created' do
  #   user_signup

  #   visit '/restaurants'
  #   click_link 'Edit KFC'
  #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
  #   end
  # end

end

context 'deleting restaurants' do

  before {Restaurant.create name: 'KFC'}

  scenario 'removes a restaurant when a user clicks a delete link' do
    user_signup
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
  end

  context 'not signed in' do
  it 'does not let a user delete a restaurant if they are not signed in' do
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  # context 'not created by user' do
  # it 'does not let a user delete a restaurant which they have not created' do
  #   visit '/restaurants'
  #   click_link 'Edit KFC'
  #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
  #   end
  # end


end

end






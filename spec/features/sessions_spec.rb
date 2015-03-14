require 'rails_helper'

feature 'Sessions', :type => :feature do
  scenario 'first time login' do
    expect{
      sign_in
    }.to change(User, :count).by(1)
    expect(current_path).to eq info_cleaner_path
  end

  scenario 'second time login' do
    user = create(:user)

    expect{
      sign_in user
    }.not_to change(User, :count)
    expect(current_path).to eq info_cleaner_path
  end

  scenario 'login failure' do
    sign_in :invalid_user

    expect(current_path).to eq getstarted_cleaner_path
  end

  scenario 'signout' do
    sign_in

    click_on 'ログアウト'

    expect(current_path).to eq getstarted_cleaner_path
  end
end

require 'rails_helper'

feature 'Roots', type: :feature do
  scenario 'visit top page' do
    visit root_path

    expect(current_path).to eq getstarted_path
    expect(page).to have_selector '#getstarted'
  end

  scenario 'visit usage page' do
    visit usage_path

    expect(page).to have_selector '#usage'
  end

  scenario 'visit faq page' do
    visit faq_path

    expect(page).to have_selector '#faq'
  end

  scenario 'visit terms page' do
    visit terms_path

    expect(page).to have_selector '#terms'
  end

  scenario 'visit privacy page' do
    visit privacy_path

    expect(page).to have_selector '#privacy'
  end

  scenario 'visit contact page' do
    visit contact_path

    expect(page).to have_selector '#contact'
  end
end

require 'rails_helper'

feature 'Roots', type: :feature do
  scenario 'show usage page' do
    visit usage_path

    expect(page).to have_selector '#usage'
  end

  scenario 'show faq page' do
    visit faq_path

    expect(page).to have_selector '#faq'
  end

  scenario 'show terms page' do
    visit terms_path

    expect(page).to have_selector '#terms'
  end

  scenario 'show privacy page' do
    visit privacy_path

    expect(page).to have_selector '#privacy'
  end

  scenario 'show contact page' do
    visit contact_path

    expect(page).to have_selector '#contact'
  end
end

require "rails_helper"

RSpec.feature "Showing an Clap" do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "The first clap", body: "Lorem Ipsum", user: john)
end

  scenario "to non-signed in user hide the Edit and Delete buttons" do
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Clap")
    expect(page).not_to have_lin("Delete Clap")

  end

  scenario "to non-owner hide the Edit and Delete buttons" do
    login_as(@fred)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Clap")
    expect(page).not_to have_lin("Delete Clap")
  end

  scenario "to signed in owner makes both links visible" do
      login_as(@john)

      visit "/"
      click_link @article.title

      expect(page).to have_content(@article.title)
      expect(page).to have_content(@article.body)
      expect(current_path).to eq(article_path(@article))

      expect(page).to have_link("Edit Clap")
      expect(page).to have_link("Delete Clap")
    end
  end

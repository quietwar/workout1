require "rails_helper"

RSpec.feature "Adding a chatroom" do

  before  do
      @john = User.create(email: "john@example.com", password: "password")
      login_as(john)
      @fred = User.create(email: "fred@example.com", password: "password")
      @article = Article.create(title: "The first clap", body: "Lorem Ipsum", user: john)
  end

  scenario "permits a signed in user to chat" do
    login_as(@fred)
    visit "/"

    click_link @article.title
    fill_in "New Clap", with: "Updated Clap"
    click_button "ClapBlack"

    expect(page).to have_content("Clapped!")
    expect(page).to have_content("Updated Clap")
    expect(page.current_path).to eq(article_path(@article.id))
  end
end

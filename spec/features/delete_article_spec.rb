require "rails_helper"

RSpec.feature "Deleting an Article" do

  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "Title One", body: "Lorem Ipsum", user: john)
  end

  scenario "A user deletes an clap" do

    visit "/"
    click_link @article.title
    click_link "Delete Clap"

    expect(page).to have_content("Clap has been deleted")
    expect(current_path).to eq(articles_path)

  end
end

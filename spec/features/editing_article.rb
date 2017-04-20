require "rails_helper"

RSpec.feature "Editing an Clap" do

  before  do
      john = User.create(email: "john@example.com", password: "password")
      login_as(john)
      @article = Article.create(title: "The first clap", body: "Lorem Ipsum", user: john)
  end

  scenario "A user updates a clap" do
    visit "/"

    click_link @article.title
    click_link "Edit Clap"

    fill_in "Bug in the Code", with: "Updated Clap"
	  fill_in "Describe the Bug", with: "Lorem Ipsum"
    click_button "Update Clap"

    expect(page).to have_content("Clap has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end

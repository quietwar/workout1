require "rails_helper"

RSpec.feature "Creating Clap" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
  end


  scenario "A user creates a new clap" do
    visit "/"

    click_link "New Clap"

    fill_in "Bug in the Code", with: "Creating a blog"
	  fill_in "Describe the Bug", with: "Lorem Ipsum"

  	click_button "Create Clap"

  	expect(page).to have_content("Clap has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by #{@john.email}")
  end

scenario "A user fails to creates a new clap" do
    visit "/"

    click_link "New Clap"

    fill_in "Title", with: ""
	  fill_in "Body", with: ""

	  click_button "Create CLap"

    expect(Article.last.user).to eq(@john)
    expect(page).to have_content("Clap has not been created")
    expect(page).to have_content("Bug in the Code can't be blank")
    expect(page).to have_content("Describe the Bug can't be blank")

  end
end

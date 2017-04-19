require "rails_helper"

RSpec.feature "Listing Claps" do

  before do
    @john = User.create(email: "john@example.com",
                       password: "password")
    @article1 = Article.create(title: "The first clap",
                body: "Lorem ipsum dolor sit amet.",
                user: @john)
    @article2 = Article.create(title: "The second clap",
                body: "Pellentesque ac ligula in tellus feugiat iaculis.",
                user: @john)
  end

  scenario "with claps created and user not signed in" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New clap")
  end

  scenario "with claps created and user signed in" do
    login_as(@john)

    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Clap")
  end

  scenario "with no claps created" do

    Article.delete_all

    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-claps") do
      expect(page).to have_content("No Claps Created")
    end
  end
end

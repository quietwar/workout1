require "rails_helper"

RSpec.feature "Deleting an Article" do

  before do
    @article = Article.create(title: "The first article", body: "Body of article one")


  scenario "A user deletes an article" do
  end
    visit "/"
    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(article_path)

  end
end
end 

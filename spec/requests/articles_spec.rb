require 'rails_helper'

RSpec.describe "Claps", type: :request do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "Title One", body: "Body of clap one", user: @john)
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit"}

      it "redirect to the sigin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own clap"
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful edit' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
    end

      it "successfully edits clap" do
      expect(response.status).to eq 200

  end
end

  describe 'GET /articles/:id' do
    context 'with existing clap' do
      before { get "/articles/#{@article.id}"}
    end

      it "handles existing clap" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing clap' do
      before { get "/articles/xxxx" }

      it "handles non-existing clap" do
        expect(response.status).to eq 302
        flash_message = "The clap you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Claps", type: :request do

  before do
    @article = Article.create(title: "Title One", body: "Body of clap one")
  end

  describe 'GET /claps/:id' do
    context 'with existing clap' do
      before { get "/claps/#{@article.id}"}

      it "handles existing clap" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing clap' do
      before { get "/claps/xxxxx"}

      it "handles non-existing clap" do
        expect(response.status).to eq 302
        flash_message = "The clap you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /manage_members" do
    it "returns http success" do
      get "/manage_members"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /manage_pages" do
    it "returns http success" do
      get "/manage_pages"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /manage_events" do
    it "returns http success" do
      get "/manage_events"
      expect(response).to have_http_status(:success)
    end
  end

end

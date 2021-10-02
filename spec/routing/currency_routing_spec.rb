require "rails_helper"

RSpec.describe Api::V1::CurrencyController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/currency").to route_to("api/v1/currency#index")
    end
  end
end
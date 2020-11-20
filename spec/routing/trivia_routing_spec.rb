require "rails_helper"

RSpec.describe TriviaController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trivia").to route_to("trivia#index")
    end

    it "routes to #new" do
      expect(get: "/trivia/new").to route_to("trivia#new")
    end

    it "routes to #show" do
      expect(get: "/trivia/1").to route_to("trivia#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/trivia/1/edit").to route_to("trivia#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/trivia").to route_to("trivia#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trivia/1").to route_to("trivia#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trivia/1").to route_to("trivia#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trivia/1").to route_to("trivia#destroy", id: "1")
    end
  end
end

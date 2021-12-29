require "rails_helper"

# Modify based on new nested path!!!
RSpec.describe TasksController, type: :routing do
  
  describe "routing" do
    it "routes to #index" do
      # expect(get: "/tasks").to route_to("tasks#index")
      # expect(get: "/categories/1/tasks").to route_to("tasks#index", category_id: "1")
      expect(get: "/categories/1").to route_to("categories#show", id:"1")
    end

    it "routes to #new" do
      # expect(get: "/tasks/new").to route_to("tasks#new")
      expect(get: "/categories/1/tasks/new").to route_to("tasks#new", category_id: "1")
    end

    it "routes to #show" do
  #     # expect(get: "/tasks/1").to route_to("tasks#show", id: "1")
      expect(get: "/categories/1/tasks/1").to route_to("tasks#show", category_id:"1", id: "1")
    end

    it "routes to #edit" do
  #     # expect(get: "/tasks/1/edit").to route_to("tasks#edit", id: "1")
      expect(get: "/categories/1/tasks/1/edit").to route_to("tasks#edit", category_id:"1",  id: "1")
    end


    it "routes to #create" do
      # expect(post: "/tasks").to route_to("tasks#create")
      expect(post: "categories/1/tasks").to route_to("tasks#create", category_id:"1")
    end

    it "routes to #update via PUT" do
  #     # expect(put: "/tasks/1").to route_to("tasks#update", id: "1")
      expect(put: "/categories/1/tasks/1").to route_to("tasks#update", category_id:"1",  id: "1")
    end

    it "routes to #update via PATCH" do
  #     # expect(patch: "/tasks/1").to route_to("tasks#update", id: "1")
      expect(patch: "/categories/1/tasks/1").to route_to("tasks#update", category_id:"1",  id: "1")
    end

    it "routes to #destroy" do
  #     # expect(delete: "/tasks/1").to route_to("tasks#destroy", id: "1")
      expect(delete: "/categories/1/tasks/1").to route_to("tasks#destroy", category_id:"1",  id: "1")
    end
  end
end

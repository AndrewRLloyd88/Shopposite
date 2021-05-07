require 'rails_helper'

RSpec.describe UsersController, type: :controller


  describe "Create User" do

    it "should not create user with invalid params" do
      before_count = User.count

      post users_path, params: { user: { name: "",
      email: "user@invalid",
      password:
      "foo",
      password_confirmation: "bar" } }
      after_count = User.count
      expect(before_count).to eq(after_count)
    end
end
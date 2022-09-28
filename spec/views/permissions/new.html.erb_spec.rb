require 'rails_helper'

RSpec.describe "permissions/new", type: :view do
  before(:each) do
    assign(:permission, Permission.new(
      uid: 1,
      admin: false,
      member: false,
      alumni: false
    ))
  end

  it "renders new permission form" do
    render

    assert_select "form[action=?][method=?]", permissions_path, "post" do

      assert_select "input[name=?]", "permission[uid]"

      assert_select "input[name=?]", "permission[admin]"

      assert_select "input[name=?]", "permission[member]"

      assert_select "input[name=?]", "permission[alumni]"
    end
  end
end

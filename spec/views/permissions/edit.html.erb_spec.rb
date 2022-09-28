require 'rails_helper'

RSpec.describe "permissions/edit", type: :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!(
      uid: 1,
      admin: false,
      member: false,
      alumni: false
    ))
  end

  it "renders the edit permission form" do
    render

    assert_select "form[action=?][method=?]", permission_path(@permission), "post" do

      assert_select "input[name=?]", "permission[uid]"

      assert_select "input[name=?]", "permission[admin]"

      assert_select "input[name=?]", "permission[member]"

      assert_select "input[name=?]", "permission[alumni]"
    end
  end
end

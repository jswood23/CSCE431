require 'rails_helper'

RSpec.describe "information/new", type: :view do
  before(:each) do
    assign(:information, Information.new(
      uid: 1,
      name: "MyString",
      email: "MyString",
      position: "MyString",
      bios: "MyText",
      phone: "MyString",
      points: 1
    ))
  end

  it "renders new information form" do
    render

    assert_select "form[action=?][method=?]", information_index_path, "post" do

      assert_select "input[name=?]", "information[uid]"

      assert_select "input[name=?]", "information[name]"

      assert_select "input[name=?]", "information[email]"

      assert_select "input[name=?]", "information[position]"

      assert_select "textarea[name=?]", "information[bios]"

      assert_select "input[name=?]", "information[phone]"

      assert_select "input[name=?]", "information[points]"
    end
  end
end

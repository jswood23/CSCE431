require 'rails_helper'

RSpec.describe "information/edit", type: :view do
  before(:each) do
    @information = assign(:information, Information.create!(
      uid: 1,
      name: "MyString",
      email: "MyString",
      position: "MyString",
      bios: "MyText",
      phone: "MyString",
      points: 1
    ))
  end

  it "renders the edit information form" do
    render

    assert_select "form[action=?][method=?]", information_path(@information), "post" do

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

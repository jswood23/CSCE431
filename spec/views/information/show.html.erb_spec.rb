require 'rails_helper'

RSpec.describe "information/show", type: :view do
  before(:each) do
    @information = assign(:information, Information.create!(
      uid: 2,
      name: "Name",
      email: "Email",
      position: "Position",
      bios: "MyText",
      phone: "Phone",
      points: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/3/)
  end
end

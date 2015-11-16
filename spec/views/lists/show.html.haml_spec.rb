require 'rails_helper'

RSpec.describe "lists/show", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      :title => "Title",
      :share_code => "Share Code",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Share Code/)
    expect(rendered).to match(//)
  end
end

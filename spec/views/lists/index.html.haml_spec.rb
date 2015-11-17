require 'rails_helper'

RSpec.describe "lists/index", type: :view do
  before(:each) do
    assign(:lists, [
      List.create!(
        :title => "Title",
        :share_code => "Share Code",
        :user => nil
      ),
      List.create!(
        :title => "Title",
        :share_code => "Share Code",
        :user => nil
      )
    ])
  end

  it "renders a list of lists" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Share Code".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

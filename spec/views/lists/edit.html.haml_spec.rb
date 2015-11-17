require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      :title => "MyString",
      :share_code => "MyString",
      :user => nil
    ))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "input#list_title[name=?]", "list[title]"

      assert_select "input#list_share_code[name=?]", "list[share_code]"

      assert_select "input#list_user_id[name=?]", "list[user_id]"
    end
  end
end

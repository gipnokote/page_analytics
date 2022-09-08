require 'rails_helper'

RSpec.describe Page, type: :model do
  it "is valid with valid attributes" do
    expect(Page.new(url: 'https://example.com')).to be_valid
  end

  it "is invalid with invalid attributes" do
    expect(Page.new()).to be_invalid
    expect(Page.new(url: ' ')).to be_invalid
  end
end

require 'rails_helper'

RSpec.describe Event, type: :model do
  before :all do
    @page = Page.find_by_url('https://example.com/one')
  end

  it "is valid with valid attributes" do
    expect(@page.events.new(event_type: 'view', ip: '127.0.0.1')).to be_valid
  end

  it "is invalid with invalid attributes" do
    expect(@page.events.new()).to be_invalid
    expect(@page.events.new(event_type: 'view')).to be_invalid
  end

  it "returns number on .events_count with valid arguments" do
    events_count = @page.events.events_count(event_type: 'view')
    expect(events_count).to eq(3)
  end

  it "returns number on .events_count with date_range" do # could check more cases with various date range combinations
    events_count = @page.events.events_count(event_type: 'view', starts_at: '2022-09-08 12:01:30')
    expect(events_count).to eq(2)
  end
end

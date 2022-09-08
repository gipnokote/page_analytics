require 'rails_helper'

RSpec.describe "Page Events API", :type => :request do
  fixtures :pages, :events
  describe "POST /" do
    context "with correct input" do
      it 'creates a page and an event' do
        post "/page_events", params: { url: 'https://google.com/three', event_type: 'view', ip: '127.0.0.1' }

        expect(response.code).to eq "200"
        expect(response.body).to eq "{\"status\":\"OK\"}" # could also JSON.parse the body for a nicer readability
      end
    end

    context "with wrong event_type" do
      it 'returns an error message' do
        post "/page_events", params: { url: 'https://google.com/three', event_type: 'wrong', ip: '127.0.0.1' }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"'wrong' is not a valid event_type\"}"
      end
    end

    context "with empty ip" do
      it 'returns an error message' do
        post "/page_events", params: { url: 'https://google.com/three', event_type: 'view', ip: '' }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"Validation failed: Ip can't be blank\"}"
      end
    end

    context "with no url" do
      it 'returns an error message' do
        post "/page_events", params: { event_type: 'view', ip: '127.0.0.1' }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"Validation failed: Url can't be blank\"}"
      end
    end
  end

  describe "GET /total" do
    context "with correct input" do
      it 'returns events_count' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view' }

        expect(response.code).to eq "200"
        expect(response.body).to eq "{\"events_count\":3}"
      end
    end

    context "with wrong event_type" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'wrong' }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"Argument 'event_type' must be one of the following: [\\\"view\\\", \\\"click\\\"]\"}"
      end
    end

    context "with no event_type" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one' }

        expect(response.code).to eq "400"
        expect(response.body).to eq  "{\"message\":\"Argument 'event_type' is required\"}"
      end
    end

    context "with correct time range" do
      it 'returns events_count: 1' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view', starts_at: '2022-09-08 12:01:30', ends_at: '2022-09-08 12:02:30' }

        expect(response.code).to eq "200"
        expect(response.body).to eq "{\"events_count\":1}"
      end
    end

    context "with only starts_at" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view', starts_at: '2022-09-08 12:01:30' }

        expect(response.code).to eq "200"
        expect(response.body).to eq "{\"events_count\":2}"
      end
    end

    context "with only ends_at" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view', ends_at: '2022-09-08 12:02:30' }

        expect(response.code).to eq "200"
        expect(response.body).to eq "{\"events_count\":2}"
      end
    end

    context "with non existent url" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://idontexist.com/one', event_type: 'view' }

        expect(response.code).to eq "404"
        expect(response.body).to eq "{\"message\":\"Record not found\"}"
      end
    end

    context "with starts_at in the future" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view', starts_at: '2099-01-01 10:00:00' }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"Argument 'starts_at' must be in the past\"}"
      end
    end

    context "with starts_at after ends_at" do
      it 'returns an error message' do
        get "/page_events/total", params: { url: 'https://example.com/one', event_type: 'view', starts_at: '2022-01-01 10:00:00', ends_at: Time.parse('2021-01-01 10:00:00') }

        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"message\":\"Argument 'starts_at' must be less or equal than 'ends_at\"}"
      end
    end
  end
end

class PageEventsController < ApplicationController
  def create
    # When registering an event, first try to find the page
    # And if it can't be found, then create it
    page = Page.find_by_url params[:url]
    page ||= Page.create! url: params[:url]

    # Register a new event for this page
    page.events.create! event_type: params[:event_type], ip: params[:ip]

    render json: { status: 'OK' }
  end

  def total
    # Having the bang here will raise an exception if the page can't be found
    page = Page.find_by_url! params[:url]

    events_count = page.events.events_count event_type: params[:event_type], starts_at: params[:starts_at], ends_at: params[:ends_at]

    render json: { events_count: events_count }
  end
end

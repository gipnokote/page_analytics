class PageEventsController < ApplicationController
  def create
    page = Page.find_by_url params[:url]
    page ||= Page.create! url: params[:url]

    page.events.create! event_type: params[:event_type], ip: params[:ip]

    render json: { status: 'OK' }
  end

  def total
    page = Page.find_by_url! params[:url]

    events_count = page.events.events_count event_type: params[:event_type], starts_at: params[:starts_at], ends_at: params[:ends_at]

    render json: { events_count: events_count }
  end
end

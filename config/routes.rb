Rails.application.routes.draw do
  defaults format: :json do
    post "/page_events", to: "page_events#create"
    get "/page_events/total", to: "page_events#total"
  end
end

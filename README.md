# Page Analytics Service

A simple web-service providing store and query functionalities for a given page's views and clicks. The querying endpoints provide the possibility of filtering and aggregating the data.

## Endpoints
* [Register Page Event](docs/create.md) : `POST /page_events/`
* [Request Page Aggregated Data](docs/total.md) : `GET /page_events/total`

## Assumptions
Service is implemented keeping the following assumption in mind:
* A "view" and a "click" are two similar event types. They have an IP and a date. In reality they would probably have more information, such as user agent or a DOM element which was clicked, but these were not added to this service PoC and could be added later if needed.

## Installing and running the Service
* Ensure you have `ruby v3.0.4` and `bundler` installed.
* git clone this repository
* run `bundle install`
* run `rails db:migrate`
* run `rails s`

You should now have the web server running on the default `http://localhost:3000`

## Testing the Service
RSpec is used to test the application. There are request tests in [`spec/requests/page_event_spec.rb`](spec/page_event_spec.rb) and model tests inside [`spec/models`](spec/models).

Tests can be executed with `bundle exec rspec`

## Postman

Postman collection is available in the [collection](docs/page_analytics_postman_collection.json) and [environment](docs/page_analytics_postman_environment.json) files.

## Improvement ideas
* More tests could be added, however for the PoC purposes this should be enough. Some tests could check if numbers change when adding a new event.
* Authorization could be added
* Better documentation by using Swagger
* The application could be fine-tuned by editing the configuration. Currently almost nothing was touched in the boilerplate rails project.
* The `page_events/total` endpoint could be changed to something better, maybe `page_events/count` or something even better
* IP and URL could be validated more properly. URL could be better handled, so that `http://url` and `http://url/` would have a same record.
* Better logging, tuned for Sentry or something like that
* Perhaps a namespace like /api or /v1 could be added
* Rubocop
* SAST
* Better name for the service :)
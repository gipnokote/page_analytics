class Event < ApplicationRecord
  belongs_to :page

  enum event_type: [ :view, :click ]

  validates :event_type, :ip, presence: true, allow_blank: false

  scope :starts_at, ->(starts_at) { where('created_at >= ?', Time.parse(starts_at)) }
  scope :ends_at, ->(ends_at) { where('created_at <= ?', Time.parse(ends_at)) }

  def self.events_count(args)
    raise ArgumentError.new "Argument 'event_type' is required" if args[:event_type].blank?
    raise ArgumentError.new "Argument 'event_type' must be one of the following: #{event_types.keys}" unless event_types.keys.include?(args[:event_type])
    raise ArgumentError.new "Argument 'starts_at' must be in the past" if args[:starts_at] && !Time.parse(args[:starts_at]).past?
    raise ArgumentError.new "Argument 'starts_at' must be less or equal than 'ends_at" if args[:starts_at] && args[:ends_at] && Time.parse(args[:starts_at]) > Time.parse(args[:ends_at])

    events = where(event_type: args[:event_type])
    events = events.starts_at(args[:starts_at]) if args[:starts_at]
    events = events.ends_at(args[:ends_at]) if args[:ends_at]

    events.count
  end
end

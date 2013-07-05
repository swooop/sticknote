class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :meetup_id    , type: String
  field :name         , type: String
  field :loc_name     , type: String
  field :lon          , type: Integer
  field :lat          , type: Integer
  field :happens_at   , type: Integer
  field :description  , type: String
  field :link         , type: String
  field :group        , type: String

  has_and_belongs_to_many :users

  # validates :name, presence: true
  # validates :description, presence: true
  # validates :link, presence: true

end

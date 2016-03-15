require "administrate/base_dashboard"

class RagiosMonitorDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    users: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    url: Field::String,
    duration: Field::String,
    contact: Field::String,
    ragiosid: Field::String,
    type: Field::String,
    code: Field::Text,
    monitor_json: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }

  COLLECTION_ATTRIBUTES = [
    :users,
    :id,
    :title,
    :url
  ]

  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  FORM_ATTRIBUTES = [
    :users,
    :id,
    :title,
    :description,
    :url,
    :duration,
    :contact,
    :ragiosid,
    :type,
    :code,
    :monitor_json,
    :created_at,
    :updated_at
  ]

end

# frozen_string_literal: true

Rails.application.config.session_store :redis_session_store, {
  key: "_#{Rails.application.class.parent_name.downcase}_session",
  redis: {
    expire_after: 8.hours,  # cookie expiration
    ttl: 8.hours,           # Redis expiration, defaults to 'expire_after'
    key_prefix: 'tt:session:',
    url: 'redis://localhost:6379/0',
  }
}

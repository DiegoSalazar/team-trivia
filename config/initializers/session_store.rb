# frozen_string_literal: true

Rails.application.config.session_store :redis_session_store, {
  key: "_#{Rails.application.class.parent_name.downcase}_session",
  redis: {
    expire_after: 120.minutes,  # cookie expiration
    ttl: 120.minutes,           # Redis expiration, defaults to 'expire_after'
    key_prefix: 'tt:session:',
    url: 'redis://localhost:6379/0',
  }
}

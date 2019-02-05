PagSeguro.configure do |config|
  config.token       = Rails.application.secrets.PAGSEGURO_TOKEN
  config.email       = Rails.application.secrets.PAGSEGURO_EMAIL
  config.environment = :sandbox # ou :sandbox. O padrão é production.
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end
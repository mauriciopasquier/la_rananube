# Configura el logger en STDOUT para nuestras tasks.
# Usar como dependencia en vez de `:environment`.
task logger: :environment do
  logger           = Logger.new($stdout)
  logger.level     = Logger::INFO
  Rails.logger     = logger
end

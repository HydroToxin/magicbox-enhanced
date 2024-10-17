def format_message(severity, timestamp, progname, msg)
  "#{timestamp.to_formatted_s(:db)} #{severity} #{progname} #{msg}\n"
end

logfile = File.open("#{Rails.root}/log/magicbox.log", 'a')
logfile.sync = true

logger = Logger.new(logfile)
logger.formatter = Logger::Formatter.new

MB_LOGGER = ActiveSupport::TaggedLogging.new(logger)
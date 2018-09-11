require 'fileutils'
class Logger
  ERROR_LOG_PATH = File.join([File.expand_path('logs', __dir__).to_s, 'error.log'])
  INFO_LOG_PATH = File.join([File.expand_path('logs', __dir__).to_s, 'info.log'])

  class << self
    def create_log_file
      return if File.exist?(Logger::ERROR_LOG_PATH) && File.exist?(Logger::INFO_LOG_PATH)
      FileUtils.mkdir_p(File.expand_path('logs', __dir__).to_s)
      FileUtils.touch(Logger::ERROR_LOG_PATH)
      FileUtils.touch(Logger::INFO_LOG_PATH)
    end

    def log(message, log_path: Logger::INFO_LOG_PATH)
      create_log_file
      return if message.to_s == ''
      File.open(log_path, 'a') do |file|
        file.write("#{message}\n")
      end
    end

    def info(message)
      log message, log_path: Logger::INFO_LOG_PATH
    end

    def error(message)
      log message, log_path: Logger::ERROR_LOG_PATH
    end
  end
end

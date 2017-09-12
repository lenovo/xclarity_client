require 'logger'
require 'fileutils'
module XClarityClient

  class XClarityLogger
    
    def initialize(global_log=nil)
      # This block below looks for a log in the project which uses 
      # this client or a defined log coming from initialize param.
      # If none of these logs exists, is created a log by default.
      @log = $lenovo_log ||= $log ||= global_log

      if not @log
        FileUtils::mkdir_p 'logs'
        file = File.open('logs/lxca_client.log', 'a+')
        file.sync = true
        @log = Logger.new file
      end

    end

    def info(header, msg)
      @log.level = Logger::DEBUG
      @log.info "[#{header}] - #{msg}"
    end

    def error(header, msg)
      @log.level = Logger::ERROR
      @log.error "[#{header}] - #{msg}"
    end
  end

end

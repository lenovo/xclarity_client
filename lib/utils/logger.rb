require 'logger'

module XClarityClient

  class XClarityLogger
    
    def initialize(global_log=nil)
      @log = $lenovo_log ||= $log ||= global_log

      if not @log
        file = File.open('../../logs/lxca_client.log', 'a+')
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
      @log.error "[#{header} - #{msg}]"
    end
  end

end

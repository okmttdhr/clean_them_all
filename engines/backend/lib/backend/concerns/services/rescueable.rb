module Backend::Concerns::Services::Rescueable
  extend ActiveSupport::Concern

  NETWORK_ERRORS = [OpenSSL::SSL::SSLError, SocketError, EOFError, Errno::ECONNRESET]
  TIMEOUT_ERRORS = [Timeout::Error]
  CSV_ERRORS     = [CSV::MalformedCSVError, ArgumentError]

  included do
    rescue_from *NETWORK_ERRORS, with: :logging_exception
    rescue_from *TIMEOUT_ERRORS, with: :logging_exception
    rescue_from *CSV_ERRORS,     with: :logging_exception_and_fail
    rescue_from Twitter::Error::ServerError, with: :logging_exception
    rescue_from Twitter::Error::ClientError, with: :logging_exception_and_fail
    rescue_from Twitter::Error do |exception|
      if (exception.message == 'exceptionecution exceptionpired' || exception.message == 'Net::OpenTimeout')
        logging_exception(exception)
      else
        logging_exception_and_fail(exception)
      end
    end
    rescue_from StandardError, with: :logging_exception_and_fail_and_raise

    def logging_exception(exception)
      logger.warn "#{exception.class.name}: #{exception.message}"
    end

    def logging_exception_and_fail(exception)
      logging_exception(exception)
      @job.fail! if @job.may_fail?
    end

    def logging_exception_and_fail_and_raise(exception)
      logging_exception_and_fail(exception)
      raise exception
    end
  end
end

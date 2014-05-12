module FirstGiving
  class Response

    attr_reader :params, :message

    def success?
      @success
    end

    def initialize(success, message, params, options = {})
      @success, @message, @params = success, message, params
    end

  end
end

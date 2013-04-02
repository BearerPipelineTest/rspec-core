module RSpec
  class << self
    # @private
    #
    # Used internally to print deprecation warnings
    def deprecate(method, alternate_method=nil, version=nil)
      lines = ["#{method} is deprecated"]
      if version
        lines.last << ", and will be removed from rspec-#{version}"
      end
      if alternate_method
        lines << "use #{alternate_method} instead"
      end

      lines << "called from #{caller(0)[2]}"

      warn_deprecation "\n" + lines.map {|l| "DEPRECATION: #{l}"}.join("\n") + "\n"
    end

    # @private
    #
    # Used internally to print deprecation warnings
    def warn_deprecation(message)
      RSpec.configuration.deprecation_io.puts(message)
    end

    # @private
    #
    # Used internally to print the count of deprecation warnings
    def deprecations?
      RSpec.configuration.deprecation_io.deprecations > 0
    end

    # @private
    #
    # Used internally to print deprecation summary
    def deprecation_message
      io = RSpec.configuration.deprecation_io
      "There were #{io.deprecations} deprecations logged to #{io.filename}"
    end

  end
end

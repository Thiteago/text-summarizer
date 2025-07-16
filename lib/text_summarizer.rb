require "text_summarizer/version"
require "text_summarizer/summarizers"
require "text_summarizer/configuration"

module TextSummarizer
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end

    def summarize(text, options = {})
      summarizer_class = select_summarizer(options)
      summarizer = summarizer_class.new(text, options)
      summarizer.summarize
    end

    private

    def select_summarizer(options)
      if options[:ai] || configuration.default_ai
        Summarizers::AISummarizer
      else
        Summarizers::SimpleSummarizer
      end
    end
  end
end

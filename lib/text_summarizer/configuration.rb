module TextSummarizer
  class Configuration
    attr_accessor :default_ai, :ollama_options

    def initialize
      @default_ai = false
      @ollama_options = {
        model: 'llama2',
        base_url: 'http://localhost:11434'
      }
    end
  end
end

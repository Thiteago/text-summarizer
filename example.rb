$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require_relative 'lib/text_summarizer'

TextSummarizer.configure do |config|
  config.default_ai = true
  config.ollama_options[:model] = 'llama2'
end

texto = <<~TEXT
   def summarize(text, options = {})
      summarizer_class = select_summarizer(options)
      summarizer = summarizer_class.new(text, options)
      summarizer.summarize
    end
TEXT

puts TextSummarizer.summarize(texto, ai: true)

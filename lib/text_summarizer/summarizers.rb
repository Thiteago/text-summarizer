require 'net/http'
require 'json'
require 'uri'

module TextSummarizer
  module Summarizers
    class BaseSummarizer
      def initialize(text, options = {})
        @text = text
        @options = options
      end

      def summarize
        raise NotImplementedError, "You must implement the summarize method"
      end
    end

    class SimpleSummarizer < BaseSummarizer
      def summarize
        sentences = @text.split('. ')
        important_sentences = sentences.select { |s| s.length > 20 && s.split.size > 5 }
        important_sentences.first(3).join('. ') + (important_sentences.size > 3 ? '...' : '')
      end
    end

    class AISummarizer < BaseSummarizer
      def summarize
        summarize_with_ollama
      end

      private

      def summarize_with_ollama
        uri = URI("#{TextSummarizer.configuration.ollama_options[:base_url]}/api/generate")
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')

        prompt = <<~PROMPT
          Resuma o seguinte texto de forma concisa e clara, mantendo os pontos principais:

          #{@text}

          Resumo:
        PROMPT

        req.body = {
          model: TextSummarizer.configuration.ollama_options[:model],
          prompt: prompt,
          stream: false
        }.to_json

        res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

        body = JSON.parse(res.body)
        body["response"]
      rescue => e
        raise TextSummarizer::Error, "Falha ao resumir com Ollama: #{e.message}"
      end
    end
  end
end

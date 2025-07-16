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
        # Implementação simples de resumo sem IA
        sentences = @text.split('. ')
        important_sentences = sentences.select { |s| s.length > 20 && s.split.size > 5 }
        important_sentences.first(3).join('. ') + (important_sentences.size > 3 ? '...' : '')
      end
    end

    class AISummarizer < BaseSummarizer
      def summarize
        # Implementação com Ollama ou outra API de IA
        if @options[:local_ollama]
          summarize_with_ollama
        else
          # Pode adicionar outros provedores de IA aqui
          summarize_with_ollama
        end
      end

      private

      def summarize_with_ollama
        require 'ollama'

        Ollama.configure do |config|
          config.base_url = TextSummarizer.configuration.ollama_options[:base_url]
        end

        prompt = <<~PROMPT
          Resuma o seguinte texto de forma concisa e clara, mantendo os pontos principais:

          #{@text}

          Resumo:
        PROMPT

        response = Ollama.generate(
          model: TextSummarizer.configuration.ollama_options[:model],
          prompt: prompt
        )

        response["response"]
      rescue => e
        raise TextSummarizer::Error, "Falha ao resumir com Ollama: #{e.message}"
      end
    end
  end
end

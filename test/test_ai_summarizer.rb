require "test_helper"
require "webmock/minitest"

class AISummarizerTest < Minitest::Test
  def setup
    TextSummarizer.configure do |config|
      config.default_ai = true
      config.ollama_options[:base_url] = 'http://localhost:11434'
    end
    WebMock.disable_net_connect!
  end

  def test_ai_summary_with_mock
    text = "Ruby é uma linguagem de programação focada em simplicidade e produtividade."
    expected_summary = "Ruby é uma linguagem simples e produtiva."

    stub_request(:post, "http://localhost:11434/api/generate")
      .to_return(body: { "response" => expected_summary }.to_json)

    summary = TextSummarizer.summarize(text, ai: true)
    assert_equal expected_summary, summary
  end
end

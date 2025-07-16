require "test_helper"

class SimpleSummarizerTest < Minitest::Test
  def setup
    TextSummarizer.configure {}
  end

  def test_simple_summary
    input = "Essa é uma frase curta. Aqui está uma frase mais longa que pode ser considerada importante. Outra importante aparece aqui. Fim."
    summary = TextSummarizer.summarize(input, ai: false)

    assert_includes summary, "mais longa"
    assert summary.length < input.length
  end
end

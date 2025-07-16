# TextSummarizer

Uma gem Ruby para resumir blocos de **texto natural** ou **código**, com ou sem uso de **IA local**, como o [Ollama](https://ollama.com).

Ideal para automatizar resumos simples ou gerar análises mais sofisticadas usando LLMs.

---

## ✨ Recursos

- ✅ Resumo simples sem IA (baseado em heurísticas)
- 🤖 Suporte opcional a IA com [Ollama](https://ollama.com)
- 🧠 Adaptável para uso com outros provedores de IA no futuro
- 📦 Interface fácil de usar via Ruby puro

---

## 📦 Instalação

```bash
git clone https://github.com/seu-usuario/text_summarizer.git
cd text_summarizer
gem build text_summarizer.gemspec
gem install ./text_summarizer-0.1.0.gem

require 'openai'

class OpenAiClient

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def chat(books)
    additional_prompt = "次に入力されたテーマのおすすめ小説を3冊作品名だけ紹介してください。著者の名前はいらないです。"
    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: additional_prompt },
            { role: "user", content: books },
          ],
      })
    response.dig("choices", 0, "message", "content")
  end
end

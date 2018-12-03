require 'http'

module MemberReminder
  module DingTalk
    def post(token, content, mobiles = [])
      mobiles = Array(mobiles)
      token ||= '2c26e98f69ce9960fdc308d8f7393dfe8f4b0d8dd04bc96766f6cbb20537091b'

      ::HTTP.post("https://oapi.dingtalk.com/robot/send?access_token=#{token}", :json => {
          msgtype: "text", 
          text: {
              content: content,
           },
           at: {
              atMobiles: [
                mobiles.map { |m| %Q["#{m}"] }.join(',')
              ], 
              isAtAll: false
          }
        }
      )
    end

    def post_markdown(token, title, content) 
      token ||= '2c26e98f69ce9960fdc308d8f7393dfe8f4b0d8dd04bc96766f6cbb20537091b'
      ::HTTP.post("https://oapi.dingtalk.com/robot/send?access_token=#{token}", :json => {
          msgtype: "markdown", 
          markdown: {
              title: title,
              text: content,
            },
          at: {
              isAtAll: true
          }
        }
      )
      # system curl
    end
  end
end
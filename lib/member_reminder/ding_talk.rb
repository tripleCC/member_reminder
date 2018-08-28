module MemberReminder
  module DingTalk
    def post(token, content, mobiles = [])
      mobiles = Array(mobiles)
      token ||= bc0c9e48cda8f2b4c1d37a033cdbc0cd35e42fbf89b789732a3370c0b2bc314e
      curl = %Q[
            curl 'https://oapi.dingtalk.com/robot/send?access_token=#{token}' \
               -H 'Content-Type: application/json' \
               -d '
              {
                "msgtype": "text", 
                "text": {
                    "content": "#{content}",
                 },
                 "at": {
                    "atMobiles": [
                      #{mobiles.map { |m| %Q["#{m}"] }.join(',')}
                    ], 
                    "isAtAll": false
                }
              }']
      # p curl
      system curl
    end
  end
end
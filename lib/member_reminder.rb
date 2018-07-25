require "member_reminder/version"
require "member_reminder/ding_talk"
require "member_reminder/member_bank"

module MemberReminder
	class MemberBank
		include DingTalk

		def post(members, content)
			members.group_by { |m| m.team.ding_token }.each do |token ,ms|
				super token, content, ms.map(&:mobile)
			end
		end

		class Member
			def post(content)
				super self, content
			end
		end
	end
end
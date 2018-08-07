require "member_reminder/string_pinyin"

module Pod
	class Specification
		def member
			@member ||= begin
				bank = MemberReminder::MemberBank.new
				member = authors.keys.map do |name|
				 	bank.members.find do |member|
				 		(Array(member.name) + Array(member.alias_names)).map(&:pinyin).include?(name.pinyin.downcase)
				 	end
				end.compact.first
				member
			end				
		end
	end
end
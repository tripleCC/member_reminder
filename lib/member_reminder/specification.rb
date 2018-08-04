require "member_reminder/string_pinyin"

module Pod
	class Specification
		def member
			@member ||= begin
				bank = MemberReminder::MemberBank.new('./boss_keeper_members.yml')
				member = authors.keys.map do |name|
				 	bank.members.find do |member|
				 		(Array(member.name) + Array(member.alias_names)).map(&:pinyin).include?(name)
				 	end
				end.compact.first
				member
			end				
		end
	end
end
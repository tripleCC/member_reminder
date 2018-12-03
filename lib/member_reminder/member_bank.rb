require 'yaml'
require 'open-uri'
require 'member_reminder/string_pinyin'

module  MemberReminder
  class MemberBank
    using StringPinyin
    
    class Team
      attr_accessor :name
      attr_accessor :ding_token
    end

    class Member
      attr_accessor :name
      attr_accessor :alias_names
      attr_accessor :team
      attr_accessor :mobile
    end

    DEFAULT_PATH = 'http://git.2dfire.net/ios/ci-yaml-shell/raw/master/boss_keeper_members.yml'

    attr_reader :member_yaml

    def initialize(path = DEFAULT_PATH)
      file = open(path || DEFAULT_PATH)
      @member_yaml = YAML.load(file.read)    
    end

    def member_of_spec(spec)
      member = spec.authors.keys.map do |name|
        members.find do |member|
          (Array(member.name) + Array(member.alias_names)).map(&:pinyin).include?(name.pinyin.downcase)
        end
      end.compact.first
      member
    end

    def members
      @members ||= begin
        mobiles = @member_yaml['mobiles']
        groups = @member_yaml['groups']

        @member_yaml['members'].map do |name, alias_names|
          member = Member.new
          member.name = name
          member.alias_names = alias_names
          member.team = teams.find do |team|
            token, _ = groups.find { |token, ms| ms.include?(name) }
            team.ding_token == token
          end
          member.mobile = mobiles[name]
          member
        end
      end
    end

    def teams
      @teams ||= begin
        @member_yaml['teams'].map do |name, token|
          team = Team.new
          team.name = name
          team.ding_token = token
          team
        end
      end
    end
  end
end
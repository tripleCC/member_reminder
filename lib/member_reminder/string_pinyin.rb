require 'chinese_pinyin'

class String
	def pinyin
		Pinyin.t(dup, splitter: '').downcase
	end
end
require 'chinese_pinyin'

module StringPinyin
	refine String do
		def pinyin
			Pinyin.t(dup, splitter: '').downcase
		end
	end
end
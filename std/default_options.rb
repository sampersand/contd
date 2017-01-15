module Std
  class DefaultOptions

    KEYWORDS = {
      '@' => Keyword::Call,
      '!' => Keyword::Get,
      ';' => Keyword::Newline,
    }

    def whitespace?; /\s/ end

    def start_comment?; '#'end
    def end_comment?; /[\n;]/ end

    def keyword?
      KEYWORDS.method(:include?).to_proc
    end
    def get_keyword(token)
      KEYWORDS[token].new( token )
    end

  end
end
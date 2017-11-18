require 'rpn_dclovell/token'

module RpnDclovell
  # Analyze strings to produce tokens
  class Lexer
    def lex(string)
      words = string.split(' ')
      words.map { |word| tokenize(word) }
    end

    private

    def tokenize(word)
      try_number(word) || try_operator(word) ||
        try_command(word) || Token.error(word)
    end

    def try_number(word)
      if word =~ /^-?[0-9]*\.[0-9]/
        Token.number(word.to_f)
      elsif word =~ /^-?[0-9]/
        Token.number(word.to_i)
      end
    end

    def try_operator(word)
      Token.operator(word) if word =~ %r{^(\+|-|\*|\/)$}
    end

    def try_command(word)
      if word =~ /^h/i
        Token::HELP
      elsif word =~ /^q/i
        Token::QUIT
      end
    end
  end
end

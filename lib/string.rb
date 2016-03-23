class String
  def rot(num = 13)
    return self.split('').collect{|ch|
      if /^[a-z]$/ === ch
	      ((ch[0] + num - 'a'[0]) % 26 + 'a'[0]).chr
      elsif /^[A-Z]$/ === ch
	      ((ch[0] + num - 'A'[0]) % 26 + 'A'[0]).chr
      else
	      ch
      end
    }.join("")
  end

  alias rot13 rot
end
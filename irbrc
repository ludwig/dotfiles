# ~/.irbrc

###############################################################################
# From http://news.ycombinator.com/item?id=1543595

def copy(str)
    IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def paste
    `pbpaste`
end

def ep
    eval(paste)
end

###############################################################################
# vim: syntax=ruby

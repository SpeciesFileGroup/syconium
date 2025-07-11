# frozen_string_literal: true

# From https://raw.githubusercontent.com/sckott/serrano/main/lib/serrano/utils.rb

def make_user_agent
  requa = "Faraday/v" + Faraday::VERSION
  habua = "Syconium/v" + Syconium::VERSION
  ua = requa + " " + habua
  if Syconium.mailto
    ua += " (mailto:%s)" % Syconium.mailto
  end
  # ua += format(' (mailto:%s)', Syconium.mailto) if Syconium.mailto
  ua
end

def field_query_handler(x)
  tmp = x.keep_if { |z| z.match(/query_/) }
  rename_query_filters(tmp)
end

def rename_query_filters(foo)
  foo = foo.tostrings
  foo = foo.map { |x, y| [x.to_s.sub("container_title", "container-title"), y] }.to_h
  foo.map { |x, y| [x.to_s.sub("query_", "query."), y] }.to_h
end

class Hash
  def tostrings
    map { |(k, v)| [k.to_s, v] }.to_h
  end
end

class Hash
  def tosymbols
    map { |(k, v)| [k.to_sym, v] }.to_h
  end
end


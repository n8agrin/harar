sys = require 'sys'
http = require 'http'
sha = require './sha1v2.js'

key = "key"
secret = "secret"
req_token = "www.term.ie"
req_path = "/oauth/example/request_token.php"
euc = encodeURIComponent

encode_parts = (parts, joiner) ->
  (euc(key) + "=" + euc(parts[key]) for key in ((key for key of parts).sort())).join(joiner || '&')

header_parts = (parts, joiner) ->
  (euc(key) + "=\"" + euc(parts[key]) + "\"" for key in ((key for key of parts).sort())).join(joiner || '&')

nonce = ->
  sha.HMACSHA1('foo', (new Date).getTime())


parts =
  oauth_callback : "http://localhost:3000/foo"
  oauth_consumer_key : key
  oauth_nonce : nonce()
  oauth_signature_method : "HMAC-SHA1"
  oauth_timestamp : (new Date).getTime()
  oauth_version : "1.0"

eparts = ["GET", encodeURIComponent("http://" + req_token + req_path), encode_parts(parts)].join('&')
signed = sha.HMACSHA1(secret + "&", eparts)
sys.puts(signed)
parts["oauth_signature"] = signed
header = "OAuth " + header_parts(parts, ",")
sys.puts(header)


client = http.createClient(80, req_token)
req = client.request("GET", req_path, {'host': req_token, "Authorization": header})
req.end()
req.on('response', (resp) ->
  sys.puts(JSON.stringify(resp.headers))
  resp.on('data', (ch) ->
    sys.puts(ch)
  )
)


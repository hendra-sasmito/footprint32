#Koala.http_service.http_options = {
#  :ssl => { :ca_path => "#{Rails.root}/config/ca-bundle.crt" }
#}

Koala.http_service.http_options = { :ssl => { :ca_file => Rails.root.join('lib/cacert.pem').to_s } }
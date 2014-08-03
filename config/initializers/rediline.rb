#rediline_config = YAML::load(Rails.root.join('config', 'rediline.yml').read)[Rails.env]
#Rediline.redis = Redis.new(
#    :host => rediline_config['host'],
#    :port => rediline_config['port'],
#    :password => rediline_config['password']
#)
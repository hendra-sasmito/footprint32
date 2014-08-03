#Paperclip.interpolates :hashed_path do |attachment, style|
#  secret = '1cd121a1fa53751b28a64422366e13ca8367cd5f68a55ef1cc1e7ee2137b05310cfcbc10f93bf282a3bd6ddde7538aa3e37ec1b46725fec7c903d44bc164a9c2'
#  hash = Digest::MD5.hexdigest("--#{attachment.class.name}--#{attachment.instance.id}--#{secret}--")
#  hash_path = ''
#  6.times { hash_path += '/' + hash.slice!(0..2) }
#  hash_path[1..24]
#end
class User
  include DataMapper::Resource

  property :id,    Integer, :required => true, :key => true
  property :name,  String,  :required => true
  property :posts, String,  :required => true
  property :karma, Integer, :default  => 1

  def inspect
    id    = self.id.inspect
    name  = self.name.inspect
    posts = MessagePack.unpack(self.posts).inspect
    karma = self.karma.inspect
    "#<#{self.class} @id=#{id} @name=#{name} @posts=#{posts} @karma=#{karma}>"
  end

  def upvote
    self.karma += 1
    save
  end
end

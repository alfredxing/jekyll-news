class User
  include DataMapper::Resource

  property :id,    Integer, :required => true, :key => true
  property :name,  String,  :required => true
  property :posts, Object,  :default  => []

  def inspect
    id    = self.id.inspect
    name  = self.name.inspect
    posts = self.posts
    "#<#{self.class} @id=#{id} @name=#{name} @posts=#{posts} @karma=#{karma}>"
  end
end

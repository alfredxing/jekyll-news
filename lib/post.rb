class Post
  include DataMapper::Resource

  property :id,     Serial
  property :time,   Object,  :required => true
  property :title,  String,  :required => true
  property :author, Integer, :required => true
  property :link,   String,  :required => true
  property :text,   Text
  property :karma,  Integer, :default  => 1

  def inspect
    id     = self.id.inspect
    title  = self.title.inspect
    link   = self.link.inspect
    author = self.author.inspect
    text   = self.text.inspect
    karma  = self.karma.inspect
    "#<#{self.class} @id=#{id} @title=#{title} @link=#{link} @author=#{author} @text=#{text} @karma=#{karma}>"
  end

  def upvote
    self.karma += 1
    save
  end
end

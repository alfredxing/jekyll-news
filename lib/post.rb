require 'set'

class Post
  include DataMapper::Resource

  property :id,     Serial
  property :time,   Object,  :required => true
  property :title,  String,  :required => true
  property :author, Integer, :required => true
  property :link,   String
  property :text,   Text
  property :karma,  Integer, :default  => 1
  property :votes,  Object,  :default  => Set.new

  def inspect
    id     = self.id.inspect
    time   = self.time
    title  = self.title.inspect
    link   = self.link.inspect
    author = self.author.inspect
    text   = self.text.inspect
    karma  = self.karma.inspect
    "#<#{self.class} @id=#{id} @time=#{time} @title=#{title} @link=#{link} @author=#{author} @text=#{text} @karma=#{karma}>"
  end

  def process
    if (self.link.nil? || self.link.empty?)
      self.link = "/post/#{self.id}"
      save
    end
    set = Set.new [self.author]
    self.votes = set
    save
  end

  def upvote(user)
    if self.upvotable?(user)
      votes = self.votes.clone.add(user)
      self.attributes = { :votes => votes, :karma => self.karma + 1 }
      save
    end
  end

  def upvotable?(user)
    !(self.votes.include?(user) || user.nil?)
  end

  def score
    (self.karma - 1) / ((Time.new - self.time)/3600 + 2)**1.8
  end
end

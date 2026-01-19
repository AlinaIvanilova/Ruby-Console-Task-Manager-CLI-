
class Task
  attr_reader :description, :created_at
  attr_accessor :id, :title, :status
  def initialize(title, description)
    @id = nil
    @title = title
    @description = description
    @status = "todo"
    @created_at = Time.now
  end
  def to_h
    {:id => @id, :title => @title, :description => @description, :status => @status, :created_at => @created_at}
  end
end


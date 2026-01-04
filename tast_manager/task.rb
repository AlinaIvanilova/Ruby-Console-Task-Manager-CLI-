
class Task
  def initialize(id, title, description)
    @id = id
    @title = title
    @description = description
    @status = "todo"
    @created_at = Time.now
  end
end

first_task = Task.new(1, "First Task", "description")
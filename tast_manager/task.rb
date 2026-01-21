# Represents a single task in the Task Manager
# Each task has a unique ID, title, description, status, and creation timestamp
class Task
  # `description` is read-only, others can be read and modified
  attr_reader :description
  attr_accessor :id, :title, :status, :created_at

  # Initialize a new Task with title and description
  # Status defaults to 'todo' and created_at is set to current time
  def initialize(title, description)
    @id = nil                # will be assigned by TaskManager
    @title = title
    @description = description
    @status = "todo"         # default status
    @created_at = Time.now   # timestamp of creation
  end

  # Convert Task object to a hash, useful for JSON serialization
  def to_h
    {
      id: @id,
      title: @title,
      description: @description,
      status: @status,
      created_at: @created_at
    }
  end

  # Display task information in a readable format for the console
  def display
    puts "ID: #{id} | Title: #{title} | Description: #{description} | Status: #{status} | Created at: #{created_at}"
  end
end

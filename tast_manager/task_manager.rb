# Manages a list of tasks: add, update, complete, delete, save/load to JSON

require 'json'

class TaskManager
  def initialize
    @tasks = []          # Array to store all Task objects
    @next_id = 1         # Track the next task ID
  end

  # Add a new task and save to JSON
  def add_task(task)
    task.id = @next_id
    @tasks << task
    @next_id += 1
    save_tasks
  end

  # Find task by ID
  def find_task_by_id(id)
    @tasks.find { |task| task.id == id }
  end

  # Mark a task as completed
  def complete_task(id)
    task = find_task_by_id(id)
    if task
      if task.status != "done"
      task.status = "done"
      save_tasks
      puts "Завдання виконано"
      else
        puts "Завдання вже виконано"
      end
    else
      puts "Задача не знайдена"
    end
  end

  # Delete a task
  def delete_task(id)
    before_count = @tasks.count
    @tasks.delete_if { |task| task.id == id }
    after_count = @tasks.count

    if before_count > after_count
      save_tasks
      puts "Задача видалена"
    else
      puts "Задача не знайдена"
    end
  end

  # List all tasks
  def list_tasks
    @tasks
  end

  # Update task title
  def update_title(id, new_title)
    task = find_task_by_id(id)
    if task
      task.title = new_title
      save_tasks
    else
      puts "Завдання не знайдено"
    end
  end

  # Update task description
  def update_description(id, new_description)
    task = find_task_by_id(id)
    if task
      task.description = new_description
      save_tasks
    else
      puts "Завдання не знайдено"
    end
  end

  # Save tasks to JSON file
  def save_tasks
    tasks_array = @tasks.map { |task| task.to_h }
    Storage.save(tasks_array)
  end

  # Load tasks from JSON file
  def load_tasks
    tasks_array = Storage.load
    tasks_array.each do |task_hash|
      task = Task.new(task_hash["title"], task_hash["description"])
      task.id = task_hash["id"]
      task.status = task_hash["status"]
      task.created_at = task_hash["created_at"]

      @tasks << task
    end
    @next_id = @tasks.map(&:id).max + 1 unless @tasks.empty?
  end
end
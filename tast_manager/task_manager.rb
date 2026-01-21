require 'json'



class TaskManager
  def initialize
    @tasks = []
    @next_id = 1
  end

  def add_task(task)
    task.id = @next_id
    @tasks << task
    @next_id += 1
    save_tasks
  end

  def find_task_by_id(id)
    @tasks.find { |task| task.id == id }
  end
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
  def list_tasks
    @tasks
  end
  def update_title(id, new_title)
    task = find_task_by_id(id)
    if task
      task.title = new_title
      save_tasks
    else
      puts "Завдання не знайдено"
    end
  end
  def update_description(id, new_description)
    task = find_task_by_id(id)
    if task
      task.description = new_description
      save_tasks
    else
      puts "Завдання не знайдено"
    end
  end
  #Json
  def save_tasks
    tasks_array = @tasks.map { |task| task.to_h }

    begin
      File.open("tasks.json", "w") do |file|
        file.write(JSON.pretty_generate(tasks_array))
      end
    rescue StandardError => e
      puts "Помилка при збереженні задач: #{e.message}"
    end
  end
  def load_tasks
    return unless File.exist?("tasks.json")
    begin
      File.open("tasks.json", "r") do |file|
        tasks_array = JSON.parse(file.read)

        tasks_array.each do |task_hash|
          task = Task.new(task_hash["title"], task_hash["description"])
          task.id = task_hash["id"]
          task.status = task_hash["status"]
          task.created_at = task_hash["created_at"]
          @tasks << task
        end
      end
      # fix id
      @next_id = @tasks.map(&:id).max + 1
    rescue JSON::ParserError => e
      puts "Помилка: не вдалось прочитати JSON. Файл пошкоджений"
      puts "Деталі: #{e.message}"
    rescue StandardError => e
      puts "Щось пішло не так: #{e.message}"
    end
  end
end
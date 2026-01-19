class TaskManager
  def initialize
    @tasks = []
    @next_id = 1
  end

  def add_task(task)
    task.id = @next_id
    @tasks << task
    @next_id += 1
  end

  def find_task_by_id(id)
    @tasks.find { |task| task.id == id }
  end
  def complete_task(id)
    task = find_task_by_id(id)
    if task
      if task.status != "done"
      task.status = "done"
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
    else
      puts "Завдання не знайдено"
    end
  end
  def update_description(id, new_description)
    task = find_task_by_id(id)
    if task
      task.description = new_description
    else
      puts "Завдання не знайдено"
    end
  end
end
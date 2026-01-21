require_relative 'task_manager'
require_relative "task"

task_manager = TaskManager.new
task_manager.load_tasks

loop do
  puts "Меню:"
  puts "1. Додати задачу"
  puts "2. Показати всі задачі"
  puts "3. Завершити задачу"
  puts "4. Видалити задачу"
  puts "5. Змінити назву задачі"
  puts "6. Змінити опис задачі"
  puts "7. Пошук одної задачі"
  puts "0. Вийти"

  choice = gets.chomp

  case choice
  when "1"
    puts "Введіть назву задачі:"
    title = gets.chomp

    puts "Введіть опис задачі:"
    description = gets.chomp

    new_task = Task.new(title, description)
    task_manager.add_task(new_task)
    puts "Задача додана!"

  when "2"
    task = task_manager.list_tasks

    if task.empty?
      puts "Список задач порожній"
    else
      task.each do |task|
        puts "ID: #{task.id}, Назва: #{task.title}, Опис: #{task.description}, Статус: #{task.status}, Створено: #{task.created_at}"
      end

    end


  when "3"
  puts "Введіть ID задачі яку треба завершити:"
  id = gets.chomp.to_i
  task_manager.complete_task(id)


  when "4"
    puts "Введіть ID задачі яку треба видалити:"
    id = gets.chomp.to_i
    task_manager.delete_task(id)

  when "5"
    puts "Ведіть ID задачі в якій треба змінити назву:"
    id = gets.chomp.to_i

    puts "Введіть нову назву:"
    new_title = gets.chomp
    task_manager.update_title(id, new_title)

  when '6'
    puts "Введіть ID задачі в якій треба змінити опис:"
    id = gets.chomp.to_i

    puts "Введіть новий опис:"
    new_description = gets.chomp
    task_manager.update_description(id, new_description)
  when '7'
    puts "Введіть ID задачі яку хочете знайти"
    id = gets.chomp.to_i

    task = task_manager.find_task_by_id(id)
    if task
      puts "ID: #{task.id}, Назва: #{task.title}, Опис: #{task.description}, Статус: #{task.status}, Створено: #{task.created_at}"
    else
      puts "Задачі не знайдено"
    end

  when "0"
    puts "До побачення!"
    break


  else
    puts "Невірний пункт. Спробуйте ще раз."
  end
end
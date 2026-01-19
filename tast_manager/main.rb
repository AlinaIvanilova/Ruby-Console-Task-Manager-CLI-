require_relative 'task_manager'
require_relative "task"

task_manager = TaskManager.new

loop do
  puts "Меню:"
  puts "1. Додати задачу"
  puts "2. Показати всі задачі"
  puts "3. Завершити задачу"
  puts "4. Видалити задачу"
  puts "5. Змінити назву задачі"
  puts "6. Змінити опис задачі"
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
  end
end
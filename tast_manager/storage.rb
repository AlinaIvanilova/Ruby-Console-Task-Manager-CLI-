require 'json'

# Handles reading/writing tasks to the JSON file
class Storage
  FILE_PATH = "tasks.json"

  # Save an array of task hashes to JSON
  def self.save(task_array)
    File.open("#{FILE_PATH}", 'w') do |file|
      file.write(JSON.pretty_generate(task_array))
    end
  rescue JSON::ParserError => e
    puts "Помилка збереження завдань: #{e.message}"
  end

  # Load array of task hashes from JSON
  def self.load
    return [] unless File.exist?(FILE_PATH)

    JSON.parse(File.read(FILE_PATH))
  rescue JSON::ParserError => e
    puts"Помилка читання JSON: #{e.message}"
    []
  end
end
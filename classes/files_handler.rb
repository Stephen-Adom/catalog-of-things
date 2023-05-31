require 'json'

class Storage
  @files_path = 'data/'
  class << self
    def path(filename)
      "#{@files_path}#{filename}"
    end

    def open_or_create_file(filename)
      File.open(path(filename), 'w')
    end

    def read_file_content(name)
      filename = path(name)
      return [] unless File.exist?(filename)

      file = File.open(filename, 'r')
      file_data = file.read
      return [] if file_data.empty?

      file_content = JSON.parse(file_data)
      file.close
      file_content
    end

    def save_file_content(filename, content)
      file = open_or_create_file(filename)
      json_string = JSON.dump(content)
      file.write(json_string)
      file.close
    end
  end
end

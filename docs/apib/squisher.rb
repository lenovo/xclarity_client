require 'json'

input_file = ARGV.first
output = 'output.apib'

def squish(json)
  return treat_as_array(json) if json.kind_of?(Array)

  return treat_as_hash(json) if json.kind_of?(Hash)

  json
end

def treat_as_array(json)
  return [squish(json.first)] unless json.empty?

  json
end

def treat_as_hash(json)
  json.map { |key, value| [key, squish(value)] }.to_h
end

File.open(output, 'w') do |file|
  file.write(
    File.open(input_file).map do |line|
      begin
        squish(JSON.parse(line)).to_json
      rescue StandardError
        line
      end
    end.join('')
  )
end

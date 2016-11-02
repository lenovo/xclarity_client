require 'json'

input_file = ARGV.first
output = "output.apib"

def squish(json) 
  if json.is_a?(Array) and json.size > 0
    [squish(json.first)]
  elsif json.is_a?(Hash)
    json.map { |key, value| [key, squish(value)] }.to_h
  else
    json
  end
end

File.open(output, 'w') do |file|
  file.write(
    File.open(input_file).map do |line|
      begin
        squish(JSON.parse line).to_json
      rescue Exception => e
        line
      end
    end.join("")
  )
end

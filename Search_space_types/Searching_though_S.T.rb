class ParsingData
  require 'json'

  def parsing_though_space_type (space_type_in)
    space_types_read = File.read(space_type_in)
    space_types = JSON.parse(space_types_read)['tables']['space_types']['table']
    wildCards = []
    insuraance =[]
    letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K']
    space_types.each do |search_string|
      letters.each do |letter|
        if search_string['space_type'].include? "-sch-#{letter}" and search_string['necb_hvac_system_selection_type'] != 'Wildcard'
          insuraance << search_string
          search_string['necb_hvac_system_selection_type'] = "Wildcard"
          wildCards << search_string
        else
          wildCards << search_string
        end
      end
    end
    puts insuraance
    if space_type_in.include? "2011"
      name = './corrected_space_types_2011.json'
    elsif space_type_in.include? "2015"
      name = './corrected_space_types_2015.json'
    elsif space_type_in.include? "2017"
      name = './corrected_space_types_2017.json'
    end
    File.open("#{name}", "w") {|each_file| each_file.write(JSON.pretty_generate(wildCards))}
  end
end

test = ParsingData.new
num = ['1', '5', '7']
num.each do |year|
  test.parsing_though_space_type ("./space_types201#{year}.json")
end

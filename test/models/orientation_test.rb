require 'test_helper'

class OrientationTest < ActiveSupport::TestCase
  test "new" do
    orientation = Orientation.new
    assert !orientation.save, "Não deveria salvar sem nenhum dado "+orientation.inspect

    orientation.timeline = Timeline.first
    assert !orientation.save, "Faltam dados "+orientation.inspect

    orientation.title = "Título da orientação"
    assert !orientation.save, "Faltam dados "+orientation.inspect

    orientation.description = "Descrição da orientação"
    assert !orientation.save, "Faltam dados "+orientation.inspect

    orientation.date = Date.new 2015, 3, 1
    assert orientation.save, "Não salvou "+orientation.inspect
  end
end
